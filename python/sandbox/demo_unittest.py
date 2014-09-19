#!/usr/bin/env python
# -*- coding: utf-8 -*-

import selenium.webdriver as webdriver
import unittest
import time


class TestLogin(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.get("https://portal-dev.dc.signintra.com/odm/pages/index.xhtml")
        
        self.usrid    = self.driver.find_element_by_name("simsId")
        self.pwd      = self.driver.find_element_by_name("simsPwd")
        self.btnlogin = self.driver.find_element_by_name("butLogin")
        
        self.action = webdriver.ActionChains(self.driver)

    def tearDown(self):
        self.driver.quit()


    def testLogin1(self):
        self.action.send_keys_to_element(self.usrid, "SHAROXIA")
        self.action.send_keys_to_element(self.pwd,   "123456")
        self.action.click(self.btnlogin)
        self.action.perform()


if __name__ == '__main__':
    unittest.main()





