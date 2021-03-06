#from bs4 import BeautifulSoup
import requests
import feedparser
import psycopg2
import sys
import pprint
import settings
import threading, time



##############################################################################################
#
#  Open the DB connection & return the pointer/cursor to the Database   
#
##############################################################################################
def openDBConnection(conn_string):
	#Define our connection string
	#conn_string = "host='localhost' dbname='alerts' user='alert_user' password='ingle@123'"
 
	# print the connection string we will use to connect
	#print ("Connecting to database\n	->%s" % (conn_string))
	try:
		# get a connection, if a connect cannot be made an exception will be raised here
		conn = psycopg2.connect(conn_string)
		conn.autocommit = True
	except:
		print("issue connecting to database")	
	# conn.cursor will return a cursor object, you can use this cursor to perform queries
	cursor = conn.cursor()
	#print ("Connected!\n")
	return cursor

##############################################################################################
#
#  Open the SourceFile & return a List of valid html/rss records   
#
##############################################################################################
def openSourceList(sourceFile,delimiter,nrOfCols):
	sourceList= []
	sourceData = open(sourceFile,"r")
	for line in sourceData:
		sourceDataLine = line.strip().split(delimiter)
		# incomplete data entries are ignored
		if (len(sourceDataLine) == nrOfCols):   
			sourceList.append(sourceDataLine)
	return sourceList

##############################################################################################
#
#  remove all inline javascript and stylesheet code   
#
##############################################################################################

def htmlSanitizer(soup):
	for script in soup(["script", "style"]): # remove all javascript and stylesheet code
		script.extract()
	text = soup.get_text()
	# break into lines and remove leading and trailing space on each
	lines = (line.strip() for line in text.splitlines())
	# break multi-headlines into a line each
	chunks = (phrase.strip() for line in lines for phrase in line.split("  "))
	# drop blank lines
	text = '\n'.join(chunk for chunk in chunks if chunk)
	return text


##############################################################################################
#
#  Extracting html content & store in a database for further processing   
#
##############################################################################################
def scraperHtml(sourceUrl,cat,rate,cursor, categoryList, keywordsList,delimiter):
	time.sleep(1)
	url = sourceUrl.strip()
	req  = requests.get("http://" +url)
	data = req.text
	soup = BeautifulSoup(data,"lxml")
	rawData = htmlSanitizer(soup)
	#rawData=rawData.replace("'","").replace("\"","").replace('\n', ' ').replace('\r', '')
	rawData=rawData.replace("'","").replace("\"","")
	#rawData = "this is a test and no killing, tsunami, bombing, storming,"
	keyList = parserDATA(categoryList,keywordsList, rawData,cat)
	if len(keyList) > 0:
		keyString = ""
		print("Following Keywords Found in ", url, keyList)
		for key in keyList:
			print(key)
			keyString = keyString + key[0] + "="+ key[1] + delimiter
		print(keyString)
		sqlStr = "insert into public.rawAlerts (name,subject,rawData,keyWords) values ('" + sourceUrl +"','"+ cat + "','" + rawData + "','" + keyString + "')"
		writeToDatabase(cursor, sqlStr)
	else:
		print("No keywords Found in", url) 
		keyString = ""	

	#print(cat)
	#print(sqlStr)


##############################################################################################
#
#  Search rawData for keywords    
#
##############################################################################################
def parserDATA(categoryList, keywordsList, rData,cat):
	catLen = len(categoryList)
	keyFoundList = []
	for catPos in range(0, catLen):
		if cat.strip().lower() in categoryList[catPos].strip().lower():
			kLen = len(keywordsList[catPos])	
			for i in range(0,kLen):
				if keywordsList[catPos][i][0].strip().lower() in rData.lower():
					keyFoundList.append(keywordsList[catPos][i])
	
	return keyFoundList

##############################################################################################
#
#  RSS Scraper (using feedparser libraries)
#
##############################################################################################
def scrapeRSS( sourceUrl,cat,rate,cursor, categoryList, keywordsList,delimiter):
	feed = feedparser.parse( sourceUrl )
	for newsItem in feed['items']:
		title = newsItem['title']
		rawData = newsItem['description']
		alertSource= newsItem['link']
		title=title.replace("'","").replace("\"","")
		rawData=rawData.replace("'","").replace("\"","")
		alertSource=alertSource.replace("'","").replace("\"","")
		timestamp = newsItem['published']
		#print(newsItem['title'])
		#print(newsItem['link'])
		#print(newsItem['description'])
		#print(newsItem['published'])
		#print(newsItem['published_parsed'])
		keyList = parserDATA(categoryList,keywordsList, rawData,cat)
		#print(keyList)
		if len(keyList) > 0:
			keyString = ""
			score = 0
			print("Following Keywords Found in ", sourceUrl, keyList)
			for key in keyList:
				print(key)
				#keyString = keyString + key[0] + "="+ key[1] + delimiter
				keyString = keyString + key[0] + ","
				score = score + int(key[1])
			sqlStr = "select * from public.rawalerts where title='" + title + "'" 
			# Check whether RSS Feed is already in the database
			rowCounter = alertDuplicateCheck(cursor,sqlStr)
			score = round(score/len(keyList),2)
			if rowCounter==0:
				print(sqlStr)
				sqlStr = "insert into public.rawAlerts (name,title, alertSource, classification,rawData,keyWords,initialRating, timestamp) values ('" + sourceUrl +"','"+ title + "','"+ alertSource + "','"+ cat + "','" + rawData + "','" + keyString + "','" + str(score) + "','" + timestamp + "')"
				writeToDatabase(cursor, sqlStr)

		else:
			#print("No keywords Found in", sourceUrl) 
			keyString = ""	




##############################################################################################
#
#  Load the list of alerts categories and corresponding keywords from file    
#
##############################################################################################
def openKeywordsList(keywordsFile,delimiter):
	categoryList= []	
	keywordsList= []
	keywords = []
	keywordsData = open(keywordsFile,"r")
	for line in keywordsData:
		rootElement = line.strip().split(":::")
		categoryList.append(rootElement[0])
		keywordsDataList = rootElement[1].strip().split(delimiter)
		for item in keywordsDataList:
			keyValue = item.split("=")
			keywords.append(keyValue)
		keywordsList.append(keywords)
		keywords = []
	return categoryList, keywordsList

##############################################################################################
#
#  Write data to the database    
#
##############################################################################################
def writeToDatabase(cursor, sqlStr):
	cursor.execute(sqlStr)


##############################################################################################
#
#  Read data from the database    
#
##############################################################################################
def readFromDatabase(cursor, sqlStr):
	cursor.execute(sqlStr)
	return cursor.fetchall()


##############################################################################################
#
#  Duplicate alerts test    
#
##############################################################################################
def alertDuplicateCheck(cursor, sqlStr):
	cursor.execute(sqlStr)
	return cursor.rowcount




# initiate the global variables from settings.cfg module
settings.init()

# load html sourcelist to a List (htmlSouceList)
htmlSourceList = openSourceList(settings.htmlSourceFile, settings.delimiter,settings.nrOfColsHtmlFile)

# load rss sourcelist to a List (rssSouceList)
rssSourceList = openSourceList(settings.rssSourceFile, settings.delimiter,settings.nrOfColsRssFile)

# load categorylist and keywords associated with each category
categoryList, keywordsList = openKeywordsList(settings.keywordsFile, settings.delimiter)

#print(categoryList[0], keywordsList[0][1][0])

# determine the # of records in html sourcelist
nrOfHtmlSources =len(htmlSourceList)

# determine the # of records in rss sourcelist
nrOfRssSources =len(rssSourceList)



# Database is opened for reading & writing data
cursor = openDBConnection(settings.conn_string)

#####################################################################
#  Scraping through multiple HTML sources 
#####################################################################


#for x in range(0,nrOfHtmlSources):
#	sourceRecord = htmlSourceList[x]
#	if sourceRecord[0] and sourceRecord[1] and sourceRecord[2] and sourceRecord[2]:
#		src = sourceRecord[1] # Url
#		cat = sourceRecord[2] # Category
#		rate = sourceRecord[3] # Rate
#		scraperHtml(src,cat,rate,cursor, categoryList, keywordsList,settings.delimiter)


#####################################################################
#  Scraping through multiple RSS sources 
#####################################################################

for x in range(0,nrOfRssSources):
	sourceRecord = rssSourceList[x]
	if sourceRecord[0] and sourceRecord[1] and sourceRecord[2] and sourceRecord[2]:
		src = sourceRecord[1] # Url
		cat = sourceRecord[2] # Category
		rate = sourceRecord[3] # Rate
		if not 'http://' in src:
			src = 'http://' + src
		src = src.replace(" ","") #remove whitespaces in url
		scrapeRSS(src,cat,rate,cursor, categoryList, keywordsList,settings.delimiter)


###################################################################
# Put the scraping process into multiple threads
###################################################################

#for x in range(0,nrOfHtmlSources):
#	sourceRecord = htmlSourceList[x]
#	if sourceRecord[0] and sourceRecord[1] and sourceRecord[2] and sourceRecord[2]:
#		src = sourceRecord[1] # Url
#		cat = sourceRecord[2] # Category
#		rate = sourceRecord[3] # Rate
#		print(src)
#		newthread = threading.Thread(target=scraperHtml, args=(src,cat,rate,cursor,categoryList,keywordsList,settings.delimiter))
#		newthread.start()


#newthread.join()
#print("threads merged")

####################################################################
# multi-threaded scraping process end
####################################################################




####################################################################
# troubleshooting section
####################################################################

#cursor.execute("SELECT * FROM users")
#sqlStr = "select * from public.rawalerts where id=22" 

# retrieve the records from the database
#records = readFromDatabase(cursor,sqlStr)

#pprint.pprint(records)
