#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys


if __name__ == "__main__":
    for arg in sys.argv:
        print arg
    
    print sys.argv[1:]
    print len(sys.argv)
    