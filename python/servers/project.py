# -*- coding: utf-8 -*-

import framework

@framework.get('/')
def index(request):
    return 'Hello World!'


framework.run()



