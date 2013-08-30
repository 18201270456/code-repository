#!/usr/bin/env python
# -*- coding: utf-8 -*-

import inspect

def func1():
    print "this is func1"
    func2()
    

def func2():
    print "this is func2"
    print inspect.getouterframes( inspect.currentframe() )[1]
    


if __name__ == '__main__':
    func1()
    
    a = "hahaha"
    print a[0:3]