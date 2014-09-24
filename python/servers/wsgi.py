# -*- coding: utf-8 -*-
'''
Description:
    Python Web Server Gateway Interface
    
Reference:
    http://legacy.python.org/dev/peps/pep-3333/
    
    
'''

from http import DemoHTTPServer, DemoHTTPRequestHandler

import os

class DemoWSGIRequestHandler(DemoHTTPRequestHandler):
    
    
    def get_environ(self):
        return self.server.base_environ.copy()
    
    
    def handle(self):
        print "handle"
        self.run(self.server.get_app())
    
    
    def run(self, application):
        self.environ = dict(os.environ.items()).copy()
        
        self.result = application(self.environ, self.start_response)
        
        self.finish_response()
    
    
    def finish_response(self):
        for data in self.result:
            self.write(data)
    
    
    def start_response(self, status, headers, exc_info=None):
        self.status = status
        return self.write
    
    
    def write(self, data):
        """'write()' callable as specified by PEP 333"""

        self.wfile.write("HTTP/1.1 200 OK")
        self.wfile.write("Content-Type: text/html;charset=utf-8\r\n")
        self.wfile.write("\r\n")
        
        self.wfile.write(data)



class DemoWSGIServer(DemoHTTPServer):
    """BaseHTTPServer that implements the Python WSGI protocol"""
    
    application = None

    def get_app(self):
        return self.application

    def set_app(self, application):
        self.application = application

    def setup_environ(self):
        env = self.base_environ = {}
        env['SERVER_NAME'] = self.server_name


def make_server(host, port, app, server_class, handler_class):
    server = server_class((host, port), handler_class)
    server.set_app(app)
    return server


def simple_app(environ, start_response):
    """Simplest possible application object"""
    start_response('200 OK', [('Content-Type','text/html')])
    return ['<html><body><h1>hello world!</h1></body></html>']

def show_environ(environ, start_response):
        start_response('200 OK',[('Content-type','text/html')])
        sorted_keys = environ.keys()
        sorted_keys.sort()
        return [
            '<html><body><h1>Keys in <tt>environ</tt></h1><p>',
            '<br />'.join(sorted_keys),
            '</p></body></html>',
        ]

if __name__ == "__main__":
#     httpd = make_server('', 8888, simple_app, DemoWSGIServer, DemoWSGIRequestHandler)
#     print "Serving on port 8888..."
#     httpd.serve_forever()

#     from wsgiref.handlers import CGIHandler
#     CGIHandler().run(simple_app)

#     from wsgiref import simple_server
#     httpd = simple_server.WSGIServer(
#         ('',8080),
#         simple_server.WSGIRequestHandler,
#     )
#     httpd.set_app(show_environ)
#     httpd.serve_forever()


    httpd = make_server('', 8888, show_environ, DemoWSGIServer, DemoWSGIRequestHandler)
    httpd.serve_forever()








