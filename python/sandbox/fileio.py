#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import datetime
import time

if __name__ == "__main__":
    
    time_now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    with open("E:\\WorkSpace\\ODMAutomation\\Result\\Summary.TXT", "a") as f:
        f.write("%s    Action: haha" % time_now)
        f.write('\n')
    
    
    
    
    