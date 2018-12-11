Travel Navigator Alerts

Installation guide v1.0  (Tested with Ubuntu)

1. Postgres installation

	installation instruction:

	https://www.howtoforge.com/tutorial/ubuntu-postgresql-installation/


	sudo apt-get -y install postgresql postgresql-contrib phppgadmin

	configuration
		sudo su - postgres
		psql
		\password postgres
		ENTER YOUR PASSWORD

2. to install pgadmin3

	sudo apt-get install pgadmin3
	run pgadmin3

3.Intall Anaconda 
	link: https://www.continuum.io/downloads

4. to install  psycopg2 (Postgres connector for Python)

	conda install psycopg2 (had to use Anaconda, may be apt-get also work)

5. feedParser (RSS Feeder)
	conda install -c anaconda feedparser=5.2.1


6. Postgres Database settings:
	database: alerts
	schema: public
	user=alert_user
	password=ingle@123

	active tables:
		rawalerts -> contains RSS data including the one graded by Pearce & Team
		filteredalerts -> contains alerts could be posted to live site

	CREATE TABLE public.rawAlerts (
	    id serial primary key,
	    name VARCHAR(500),
	    title VARCHAR(1000),
	    alertSource VARCHAR(1000),
	    rawData  TEXT,
	    timestamp VARCHAR(200),
	    keywords VARCHAR(500),
	    locationKeywords VARCHAR(500),
	    orderNr integer,
	    classification VARCHAR(200),
	    initialRating VARCHAR(100),
	    finalRating VARCHAR(100)
	);


	CREATE TABLE public.filteredAlerts (
	    id serial primary key,
	    name VARCHAR(500),
	    title VARCHAR(1000),
	    alertSource VARCHAR(1000),
	    rawData  TEXT,
	    timestamp VARCHAR(200),
	    keywords VARCHAR(500),
	    locationKeywords VARCHAR(500),
	    orderNr integer,
	    classification VARCHAR(200),
	    initialRating VARCHAR(100),
	    finalRating VARCHAR(100),
	    originalId integer
	);


7. To Add a new RSS source -> rsssources.cfg
	format: site ##$$## url ### classification ### trustLevel
	example: CBC World News  ##$$##  www.cbc.ca/cmlink/rss-world ##$$## security ##$$## 9 
	note: A single site could have different trustLevel for different classifications (security, health ...), therefore need to add line for each classification


8. To Modify keywords list -> keywords.cfg
`	format: classsifiction:::keyword1=rate1 ##$$## keyword2=rate2 ##$$## keyword3=rate3
	example: security:::war=7 ##$$## civil war=7 ##$$## shooting=6 ##$$## shooter=7



9. Web Interface: Developed in PHP
	files:	index.php  // includes navigation to other pages
		all.php // include all RSS feeds including graded & not-graded
		complete.php // include only the ones (RSS feed) completed
		incomplete.php // include only the one not completed.
		active_alerts.php // enables to select completed RSS to copy to filteredAlerts table.


		

