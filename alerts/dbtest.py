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

	# get a connection, if a connect cannot be made an exception will be raised here
	conn = psycopg2.connect(conn_string)
 
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
		if (len(sourceDataLine) == 3):
			sourceList.append(sourceDataLine)
	return sourceList



def scraperHtml(sourceRecord):
	if sourceRecord[0] and sourceRecord[1] and sourceRecord[2] :
		print(sourceRecord[1])
		url = sourceRecord[1].strip()
		r  = requests.get("http://" +url)
		data = r.text
		soup = BeautifulSoup(data,"html")
		for link in soup.find_all('a'):
    			print(link.get('href'))



settings.init()
htmlSourceList = openSourceList(settings.htmlSourceFile, settings.delimeter)

print (htmlSourceList)

scraperHtml(htmlSourceList[0])

rssSourceList = openSourceList(settings.rssSourceFile, settings.delimeter)

print (rssSourceList)

cursor = openDBConnection(settings.conn_string)

cursor.execute("SELECT * FROM users")
 
# retrieve the records from the database
records = cursor.fetchall()
 
# print out the records using pretty print
# note that the NAMES of the columns are not shown, instead just indexes.
# for most people this isn't very useful so we'll show you how to return
# columns as a dictionary (hash) in the next example.
pprint.pprint(records)
