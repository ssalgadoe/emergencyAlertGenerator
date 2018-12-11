import threading, time


def hello(string1,string2):
    for i in range(1,5):
        time.sleep(1)
        print(string1,string2)

def world():
    for i in range(1,5):
        time.sleep(1)
        print("World")


for x in range(1,5):
	newthread = threading.Thread(target=hello, args=(x,"dupa2"))
	newthread.start()


# Just for clarity
newthread.join()





print("end")
