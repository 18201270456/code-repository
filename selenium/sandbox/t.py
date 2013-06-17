from selenium import webdriver
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait # available since 2.4.0
from selenium.webdriver.support import expected_conditions as EC # available since 2.26.0


# Create a new instance of the Firefox driver
#driver = webdriver.Firefox()
driver = webdriver.Ie("E:\WorkSpace\Selenium\WebDriver\IEDriverServer.exe")
#driver = webdriver.Chrome("E:\WorkSpace\Selenium\WebDriver\chromedriver.exe")


# go to the google home page
driver.get("http://203.208.46.145/")

# find the element that's name attribute is q (the google search box)
inputElement = driver.find_element_by_name("q")

# type in the search
inputElement.send_keys("Cheese!")

# submit the form (although google automatically searches now without submitting)
inputElement.submit()

# the page is ajaxy so the title is originally this:
print driver.title

try:
    # we have to wait for the page to refresh, the last thing that seems to be updated is the title
    WebDriverWait(driver, 10).until(EC.title_contains("cheese!"))

    # You should see "cheese! - Google Search"
    print driver.title

finally:
    driver.quit()


print "haha"