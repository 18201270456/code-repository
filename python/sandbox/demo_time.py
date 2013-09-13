#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import datetime
import time


if __name__ == '__main__':
    time1 = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    time1 = datetime.datetime.now().replace(microsecond=0)
    time.sleep(2)
    time2 = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    time2 = datetime.datetime.now().replace(microsecond=0)
    
    t = time2 - time1
    print time1
    print time2
    print t
    print sys.path
    





