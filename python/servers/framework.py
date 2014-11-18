# -*- coding: utf-8 -*-

import wsgi



def get(url):
    """Registers a method as capable of processing GET requests."""
    def wrapped(method):
        # Register.
        return method
    return wrapped


def handle_request(environ, start_response):
    """The main handler. Dispatches to the user's code."""
    pass
#===============================================================================
#     try:
#         request = Request(environ, start_response)
#     except Exception, e:
#         return handle_error(e)
# 
#     try:
#         (re_url, url, callback), kwargs = find_matching_url(request)
#         response = callback(request, **kwargs)
#     except Exception, e:
#         return handle_error(e, request)
# 
#     if not isinstance(response, Response):
#         response = Response(response)
# 
#     return response.send(start_response)
#===============================================================================


def run():
    
    http_server = wsgi.DemoWSGIServer(("0.0.0.0", 8888), wsgi.DemoWSGIRequestHandler)
    http_server.set_app(handle_request)
    http_server.serve_forever()







