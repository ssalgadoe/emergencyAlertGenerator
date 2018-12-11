def init():
	global conn_string
	global sourceTypes
	global delimiter
	global nrOfThreads
	global nrOfColsHtmlFile	
	global htmlSourceFile
	global rssSourceFile
	global keywordsFile
	global TrustLevelType
	global InitialRatingType
	global FinalRatingType
	

	conn_string = "host='localhost' dbname='alerts' user='alert_user' password='ingle@123'"
	sourceTypes = "html,rss"
	delimiter = "##$$##"
	nrOfThreads = 5
	nrOfColsHtmlFile = 4
	htmlSourceFile = "htmlsources.cfg"
	rssSourceFile = "rsssources.cfg"
	keywordsFile = "keywords.cfg"
	TrustLevelType = [1,2,3,4,5,6,7,8,9,10]
	InitialRatingType = [0.0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0,7.5,8.0,8.5,9.0,9.5,10.0]
	FinalRatingType = [0.0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0,7.5,8.0,8.5,9.0,9.5,10.0]



