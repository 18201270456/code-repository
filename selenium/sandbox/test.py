from selenium import webdriver

chrome_option = webdriver.ChromeOptions()
chrome_option.add_argument("--proxy-server=10.213.20.62:80" )

driver = webdriver.Chrome(executable_path='E:\Selenium\WebDrivers\chromedriver.exe',
                          chrome_options=chrome_option)

#driver = webdriver.Ie(executable_path="E:\Selenium\WebDrivers\IEDriverServer.exe")


driver.get("http://203.208.46.145/")

inputElement = driver.find_element_by_name("q")
inputElement.send_keys("Cheese!")
# inputElement.submit()


driver.quit()
print "haha"

'''
# Create a new instance of the Firefox driver
#driver = webdriver.Firefox()

from selenium.webdriver import Proxy

proxy = webdriver.Proxy()

#proxy.auto_detect()

# PROXY = "10.213.20.62:80"
# 
# 
chrome_option = webdriver.ChromeOptions()
chrome_option.add_argument('--proxy-server=10.213.20.62:80' )

#driver = webdriver.Chrome(executable_path='E:\Selenium\WebDrivers\chromedriver.exe')

#cap = webdriver.DesiredCapabilities.CHROME

cap = webdriver.DesiredCapabilities.CHROME['chrome.switches'] = ['--proxy-server=10.213.20.62:80']
#cap.setdefault(proxy)


#driver = webdriver.Ie(executable_path="E:\Selenium\WebDrivers\IEDriverServer.exe", capabilities=cap)
driver = webdriver.Chrome(executable_path='E:\Selenium\WebDrivers\chromedriver.exe', 
                          chrome_options=chrome_option, 
                          desired_capabilities=cap)


print "haha"


# go to the google home page
driver.get("http://hewang:pwd@203.208.46.145/")

# find the element that's name attribute is q (the google search box)
inputElement = driver.find_element_by_name("q")

# type in the search
inputElement.send_keys("Cheese!")

# submit the form (although google automatically searches now without submitting)
inputElement.submit()

# the page is ajaxy so the title is originally this:
#print driver.title
print "haha"


try:
    # we have to wait for the page to refresh, the last thing that seems to be updated is the title
    WebDriverWait(driver, 10).until(EC.title_contains("cheese!"))

    # You should see "cheese! - Google Search"
    print driver.title

finally:
    driver.quit()
'''





