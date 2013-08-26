#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pkg1.m1 import M1BC
import pkg2
import sys
import pkg1.m1

import inspect


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


class T2(T1):
    @classmethod
    def test5(cls):
        for base in cls.__class__.__bases__:
            print base.__name__
        

if __name__ == "__main__":
    #M1BC()
    #T1().test1()
    
    print inspect.getmro(T2)

    '''
    from pkg2 import m2
    m2.v2 = 22
    from pkg2 import m2
    print m2.v2
    '''

