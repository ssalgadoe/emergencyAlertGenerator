from bs4 import BeautifulSoup
#import urllib.request
import requests

url = "www.google.ca"
r  = requests.get("http://" +url)
data = r.text
soup = BeautifulSoup(data,"lxml")
for link in soup.find_all('a'):
    print(link.get('href'))
