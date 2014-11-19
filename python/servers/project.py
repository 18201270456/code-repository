# -*- coding: utf-8 -*-

#===============================================================================
# This is a demo project, using the demo framework.
#===============================================================================

import framework

@framework.get('/')
def index(request):
    return 'Hello World!'

@framework.get('/foobar')
def foobar(request):
    return 'Now, your are requesting "/foobar"'



framework.run()






