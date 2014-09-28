# -*- coding: utf-8 -*-
'''
Description:
    Python Web Server Gateway Interface
    
Reference:
    http://legacy.python.org/dev/peps/pep-3333/
    
    
'''

from http import DemoHTTPServer, DemoHTTPRequestHandler

import os, sys


class DemoWSGIServerHandler:

    def __init__(self, stdin, stdout, stderr, environ,
        multithread=True, multiprocess=False
    ):
        self.stdin             = stdin
        self.stdout            = stdout
        self.stderr            = stderr
        self.base_env          = environ
        self.wsgi_multithread  = multithread
        self.wsgi_multiprocess = multiprocess
    
    
    def run(self, application):
        try:
            self.setup_environ()
            self.result = application(self.environ, self.start_response)
            self.finish_response()
        except:
            try:
                self.handle_error()
            except:
                # If we get an error handling an error, just give up already!
                self.close()
                raise   # ...and let the actual server figure it out.
    
    
    def close(self):
        """Close the iterable (if needed) and reset all instance vars

        Subclasses may want to also drop the client connection.
        """
        try:
            if hasattr(self.result,'close'):
                self.result.close()
        finally:
            self.result = self.headers = self.status = self.environ = None
            self.bytes_sent = 0; self.headers_sent = False

    def write(self, data):
        """'write()' callable as specified by PEP 333"""

        self.wfile.write("HTTP/1.1 200 OK")
        self.wfile.write("Content-Type: text/html;charset=utf-8\r\n")
        self.wfile.write("\r\n")
        
        self.wfile.write(data)





class DemoWSGIRequestHandler(DemoHTTPRequestHandler):
    
    os_environ = dict(os.environ.items())
    
    
    def get_environ(self):
        env = self.server.base_environ.copy()
    
        env['SERVER_PROTOCOL'] = self.request_version
        env['REQUEST_METHOD'] = self.command
        
        env['REMOTE_ADDR'] = self.client_address[0]
        
        env['wsgi.input']        = sys.stdin
        env['wsgi.errors']       = sys.stderr
        env['wsgi.version']      = (1, 0, 1)
        env['wsgi.run_once']     = False
        env['wsgi.url_scheme']   = "http"
        env['wsgi.multithread']  = False
        env['wsgi.multiprocess'] = True
        
        
        
        return env
    
    

    
    
    def handle(self):
        self.run(self.server.get_app())
    
    
    
    
    



class DemoWSGIServer(DemoHTTPServer):
    
    application = None
    
    
    def server_bind(self):
        DemoHTTPServer.server_bind(self)
        self.setup_environ()
    
    
    def setup_environ(self):
        env = self.base_environ  = {}
        env['SERVER_NAME']       = self.server_name
        env['GATEWAY_INTERFACE'] = 'CGI/1.1'
        env['SERVER_PORT']       = str(self.server_port)
        env['REMOTE_HOST']       = ''
        env['CONTENT_LENGTH']    = ''
        env['SCRIPT_NAME']       = ''
    
    
    def get_app(self):
        return self.application
    
    
    def set_app(self, application):
        self.application = application





def simple_app(environ, start_response):
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
    
    
    http_server = DemoWSGIServer(("0.0.0.0", 8888), DemoWSGIRequestHandler)
    http_server.set_app(simple_app)
    http_server.serve_forever()
    
    







