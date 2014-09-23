# -*- coding: utf-8 -*-


from Queue import Queue
import random
import threading
import time


class Producer(threading.Thread):

    def __init__(self, thread_name, queue):
        threading.Thread.__init__(self, name=thread_name)
        self.data = queue
    
    def run(self): 
        for i in range(5):
            print "[%s]: Thread [%s] is produced [%d] to the queue!" %(time.ctime(), self.name, i)
            self.data.put(i)
            time.sleep(random.randrange(10)/5)
        
        print "[%s]: Thread [%s] finished!\n" %(time.ctime(), self.name)




class Consumer(threading.Thread):
    
    def __init__(self, thread_name, queue):
        threading.Thread.__init__(self, name=thread_name)
        self.data=queue
    
    def run(self):
        for i in range(5):
            val = self.data.get()
            print "[%s]: Thread [%s] => [%d] in the queue is consumed!" %(time.ctime(), self.getName(), val)
            time.sleep(random.randrange(10))
        
        print "[%s]: Thread [%s] finished!\n" %(time.ctime(), self.getName())





queue = Queue()

producer = Producer('ProducerThread', queue)
consumer = Consumer('ConsumerThread', queue)

producer.start()
consumer.start()

## blocks the calling thread until the thread whose join() method is called terminates
consumer.join()
producer.join()

print 'All threads terminate!'











