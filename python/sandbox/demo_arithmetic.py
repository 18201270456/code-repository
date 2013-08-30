#!/usr/bin/env python
# -*- coding: utf-8 -*-


def arithmetic_test(par1, par2):
    print "par1=%d" % int(int(par1) + 1)
    #print par1 + par2

if __name__ == '__main__':
    arithmetic_test("1", int("3"))
    t = "E:\\c\\t.txt"
    print t.split('\\')[-1].split('/')[-1]
