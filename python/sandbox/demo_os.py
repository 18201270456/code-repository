import os

os.system("TASKKILL /F /IM iexplore.exe")
os.system("TASKKILL /F /IM IEDriverServer.exe")
a = os.system("TASKKILL /F /IM chromedriver.exe > null")

