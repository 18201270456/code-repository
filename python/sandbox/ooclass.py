#!/usr/bin/env python
# -*- coding: utf-8 -*-

class TestClass(object):
    p1 = "hi"
    
    def __init__(self, getp1, getp2):
        self.p1 = getp1
        self.p2 = getp2
    
    def fun1(self, parameter1):
        return parameter1



if __name__ == '__main__':
    t = TestClass(1, 2)
    print t.fun1("haha")

    print TestClass.fun1(t, "hehe")
    
    print TestClass.p1
    TestClass.p1 = "nono"
    print TestClass.p1
    print t.p1




