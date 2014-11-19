# -*- coding: utf-8 -*-

#===============================================================================
# This is a demo framework with WSGI standard.
#===============================================================================


import wsgi

#===============================================================================
# Description:
#    Map requesting URL to a method.
# 
# Example:
#    GET_URL_MAPPINGS['/']       = index
#    GET_URL_MAPPINGS['/foobar'] = foobar
#===============================================================================
GET_URL_MAPPINGS = {}



def add_slash(url):
    """Adds a trailing slash for consistency in urls."""
    if not url.endswith('/'):
        url = url + '/'
    return url


# Decorator
def get(url):
    """Registers a method as capable of processing GET requests."""
    def wrapped(method):
        # Register.
        GET_URL_MAPPINGS[add_slash(url)] = method
        return method
    return wrapped



def handle_request(environ, start_response):
    """The main handler. Dispatches to the user's code."""
    
    start_response('200 OK', [('content-type', 'text/html')])
    
    request = None
    
    request_url    = add_slash(environ['PATH_INFO'])
    request_method = environ['REQUEST_METHOD']
    
    response_message = []
    response_message.append("<html><body>")
    response_message.append("<p>You are requesting method = %s</p>" % request_method )
    response_message.append("<p>You are requesting URL = %s</p>" % request_url )
    
    if GET_URL_MAPPINGS.has_key(request_url):
        response_message.append("<p>Your Requesting Answer: %s</p>" % GET_URL_MAPPINGS[request_url](request))
    else:
        response_message.append("<p>Your requesting is not supported by this framework! :(</p>")
    
    response_message.append("</body></html>")
    
    return response_message



def run():
    http_server = wsgi.DemoWSGIServer(("0.0.0.0", 8888), wsgi.DemoWSGIRequestHandler)
    http_server.set_app(handle_request)
    http_server.serve_forever()







