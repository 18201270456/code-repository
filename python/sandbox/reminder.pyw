import ctypes
import datetime
import time



msgbox = ctypes.windll.user32.MessageBoxA



while True:
    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    nowminute = datetime.datetime.now().strftime('%M')
    
    if nowminute == "45":
        msgbox(None, '[' + now + ']:  Time for a BREAK!! Go for a WALK!!!', 'WARNING', 0)
    
    time.sleep(60)

