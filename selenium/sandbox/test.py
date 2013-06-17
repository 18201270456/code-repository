import ctypes


MessageBox = ctypes.windll.user32.MessageBoxA
MessageBox(None, 'Hello', 'Window title', 0)




