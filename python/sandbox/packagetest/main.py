#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pkg1.m1 import M1BC
import pkg2
import sys



class T1(object):
    def test1(self):
        try:
            self.test2()
            print "hehe"
        except:
            print sys.exc_info()
    
    def test2(self):
        self.test3()
    
    def test3(self):
        raise NameError('HiThere')

if __name__ == "__main__":
    M1BC()
    T1().test1()


