﻿#!/usr/bin/env python
# -*- coding: utf-8 -*-

import selenium.webdriver as webdriver
import browser
from selenium.webdriver.common.by import By
import time
from selenium.selenium import selenium



class WebElement(object):
    (by, value) = (None, None)
    
    @classmethod
    def Set(cls, value):
        element = browser.driver.find_element(cls.by, cls.value)
        
        element.clear()
        action = webdriver.ActionChains(browser.driver)
        action.send_keys_to_element(element, value)
        action.perform()

    @classmethod
    def Get(cls):
        element = browser.driver.find_element(cls.by, cls.value)
        
        return element.get_attribute('value')

    @classmethod
    def Click(cls):
        element = browser.driver.find_element(cls.by, cls.value)
        
        action = webdriver.ActionChains(browser.driver)
        action.click(element)
        action.perform()

    @classmethod
    def MouseOver(cls):
        element = browser.driver.find_element(cls.by, cls.value)
        
        
        action = webdriver.ActionChains(browser.driver)
        action.move_to_element(element)
        action.move_to_element_with_offset(element, 100, 100)
        action.perform()


class Login(object):
    class UserName(WebElement):
        (by, value) = (By.NAME, "simsId")
    
    class Password(WebElement):
        (by, value) = (By.NAME, "simsPwd")

    class LoginButton(WebElement):
        (by, value) = (By.NAME, "butLogin")


class Baidu(object):
    class SearchInput(WebElement):
        (by, value) = (By.ID, "kw")


browser.driver.get("http://www.baidu.com")

Baidu.SearchInput.Set("selenium")

element = browser.driver.find_element(By.ID, "kw")

time.sleep(3)
Baidu.SearchInput.MouseOver()
Baidu.SearchInput.Set("tosca")
time.sleep(3)

print Baidu.SearchInput.Get()

'''
browser.driver.get("https://portal-dev.dc.signintra.com/odm/pages/index.xhtml")


time.sleep(3)
Login.UserName.Set("haha")
time.sleep(3)
Login.UserName.MouseOver()
time.sleep(3)
Login.Password.Set("123")
Login.LoginButton.Click()

#browser.driver.find_element(by, value)

time.sleep(3)


'''
browser.driver.quit()








