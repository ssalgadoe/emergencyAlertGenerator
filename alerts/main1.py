from bs4 import BeautifulSoup
import requests
import psycopg2
import sys
import pprint
import settings


#conn_string = "host='localhost' dbname='alerts' user='alert_user' password='ingle@123'"



##############################################################################################
#
#  Open the DB connection & return the pointer/cursor to the Database   
#
##############################################################################################
def openDBConnection(conn_string):
	#Define our connection string
	#conn_string = "host='localhost' dbname='alerts' user='alert_user' password='ingle@123'"
 
	# print the connection string we will use to connect
	print ("Connecting to database\n	->%s" % (conn_string))
	try:
		# get a connection, if a connect cannot be made an exception will be raised here
		conn = psycopg2.connect(conn_string)
		conn.autocommit = True
	except:
		print("issue connecting to database")	
	# conn.cursor will return a cursor object, you can use this cursor to perform queries
	cursor = conn.cursor()
	print ("Connected!\n")
	return cursor

##############################################################################################
#
#  Open the SourceFile & return a List of valid html/rss records   
#
##############################################################################################
def openSourceList(sourceFile,delimeter):
	sourceList= []
	sourceData = open(sourceFile,"r")
	for line in sourceData:
		sourceDataLine = line.strip().split(delimeter)
		# incomplete data entries are ignored
		if (len(sourceDataLine) == 4):
			sourceList.append(sourceDataLine)
	return sourceList

##############################################################################################
#
#  Extracting html content & store in a database for further processing   
#
##############################################################################################
def scraperHtml(sourceRecord):
	if sourceRecord[0] and sourceRecord[1] and sourceRecord[2] and sourceRecord[2]:
		#print(sourceRecord[1])
		url = sourceRecord[1].strip()
		req  = requests.get("http://" +url)
		data = req.text
		soup = BeautifulSoup(data,"lxml")
		#for link in soup.find_all('a'):
    		#	print(link.get('href'))


##############################################################################################
#
#  Load the list of alerts categories and corresponding keywords from file    
#
##############################################################################################
def openKeywordsList(keywordsFile,delimeter):
	categoryList= []	
	keywordsList= []
	keywords = []
	keywordsData = open(keywordsFile,"r")
	for line in keywordsData:
		rootElement = line.strip().split(":::")
		categoryList.append(rootElement[0])
		keywordsDataList = rootElement[1].strip().split(delimeter)
		for item in keywordsDataList:
			keyValue = item.split("=")
			keywords.append(keyValue)
		keywordsList.append(keywords)
		keywords = []
	return categoryList, keywordsList

##############################################################################################
#
#  Write data to database    
#
##############################################################################################
def writeToDatabase(cursor, sqlStr):
	cursor.execute(sqlStr)


##############################################################################################
#
#  Read data from database    
#
##############################################################################################
def readFromDatabase(cursor, sqlStr):
	cursor.execute(sqlStr)
	return cursor.fetchall()



# initiate the global variables from settings.cfg module
settings.init()


htmlSourceList = openSourceList(settings.htmlSourceFile, settings.delimeter)

#print (htmlSourceList)

scraperHtml(htmlSourceList[0])

rssSourceList = openSourceList(settings.rssSourceFile, settings.delimeter)

#print (rssSourceList)


categoryList, keywordsList = openKeywordsList(settings.keywordsFile, settings.delimeter)

#print(categoryList[0], keywordsList[0][1][0])


cursor = openDBConnection(settings.conn_string)



sqlStr = "insert into public.users (name) values ('test user7')"
writeToDatabase(cursor, sqlStr)

#cursor.execute("SELECT * FROM users")
sqlStr = "select * from users" 

# retrieve the records from the database
records = readFromDatabase(cursor,sqlStr)

pprint.pprint(records)
