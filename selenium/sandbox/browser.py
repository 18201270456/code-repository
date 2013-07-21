#!/usr/bin/env python
# -*- coding: utf-8 -*-

from selenium.webdriver.common.by import By

import selenium.webdriver as webdriver
import time


firefox = webdriver.Firefox()

firefox.get("http://stackoverflow.com/questions/17763112/selenium-mouse-over-not-works-in-firefox")
element = firefox.find_element_by_xpath("//*[@id=\"question\"]/table/tbody/tr[1]/td[2]/div/div[2]/a[3]")


action = webdriver.ActionChains(firefox)
action.move_to_element(element)
action.perform()


time.sleep(5)
firefox.quit()
'''
firefox.get("http://www.baidu.com")


input = firefox.find_element_by_id("kw")

action = webdriver.ActionChains(firefox)
action.send_keys_to_element(input, "testvalue")
action.perform()

#This step (move mouse over "input" element) NOT work! :(
action = webdriver.ActionChains(firefox)
action.move_to_element(input)
action.perform()


time.sleep(3)
firefox.quit()

'''


#pf = webdriver.FirefoxProfile()

#pf.set_preference("webdriver_enable_native_events", True)

#firefox = webdriver.Firefox(firefox_profile=pf)
#firefox = webdriver.Firefox()

#driver of the whole project.
#driver = firefox

'''
chrome_option = webdriver.ChromeOptions()
chrome_option.add_argument("--proxy-server=10.213.20.62:80" )
chrome_option._binary_location = 'D:\green\Chrome\Application\chrome.exe'

chrome = webdriver.Chrome(executable_path='E:\DevTool\Selenium\WebDriver\chromedriver.exe',
                          )
'''

#driver = firefox

'''
chrome_option = webdriver.ChromeOptions()
chrome_option.add_argument("--proxy-server=10.213.20.62:80" )
chrome_option._binary_location = 'D:\green\Chrome\Application\chrome.exe'

chrome = webdriver.Chrome(executable_path='E:\Selenium\WebDrivers\chromedriver.exe',
                          chrome_options=chrome_option)
'''









