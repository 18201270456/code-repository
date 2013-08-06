#!/usr/bin/env python
# -*- coding: utf-8 -*-

import _winreg



if __name__ == '__main__':
    key = _winreg.OpenKey(_winreg.HKEY_USERS, r"S-1-5-21-2334002601-1740315592-1067419479-16341\Software\Microsoft\Windows\CurrentVersion\Internet Settings")
                                
    value, type = _winreg.QueryValueEx(key, "ProxyOverride")
    print value
    
    _winreg.SetValue(key,"ProxyOverride",type,"localhost;10.*.*.*;msxmail1.schenker-asia.com;127.0.0.3;<local>")
    
    value, type = _winreg.QueryValueEx(key, "ProxyOverride")
    print value