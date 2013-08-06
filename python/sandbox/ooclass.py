#!/usr/bin/env python
# -*- coding: utf-8 -*-
import inspect
import sys

class TestClass(object):
    p1 = "hi"
    
    def __init__(self, getp1, getp2):
        self.p1 = getp1
        self.p2 = getp2
    
    def fun1(self, parameter1):
        return parameter1
    
    def fun22(self):
        print inspect.stack()[0][3]
        print sys._getframe().f_code.co_name



if __name__ == '__main__':
    t = TestClass(1, 2)
    print t.fun1("haha")

    print TestClass.fun1(t, "hehe")
    
    print TestClass.p1
    TestClass.p1 = "nono"
    print TestClass.p1
    print t.p1
    
    t.fun22()




