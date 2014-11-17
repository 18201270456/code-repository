# -*- coding: utf-8 -*-
'''
Description:
    Python Web Server Gateway Interface
    
Reference:
    https://www.python.org/dev/peps/pep-3333/
    
    
'''

from http import DemoHTTPServer, DemoHTTPRequestHandler

import os, sys


class DemoWSGIServerHandler:
    """Manage the invocation of a WSGI application"""
    
    
    def __init__(self, stdin, stdout, stderr, environ, multithread=True, multiprocess=False):
        self.stdin             = stdin
        self.stdout            = stdout
        self.stderr            = stderr
        self.base_env          = environ
        self.wsgi_multithread  = multithread
        self.wsgi_multiprocess = multiprocess
    
    
    def setup_environ(self):
        """Set up the environment for one request"""
        
        self.environ = dict(os.environ.items()).copy()
        self.environ.update(self.base_env)
        
        self.environ['wsgi.input']        = self.stdin
        self.environ['wsgi.errors']       = self.stderr
        self.environ['wsgi.version']      = (1, 0)
        self.environ['wsgi.run_once']     = False
        self.environ['wsgi.url_scheme']   = "http"
        self.environ['wsgi.multithread']  = True
        self.environ['wsgi.multiprocess'] = True
    
    
    def run(self, application):
        """Invoke the application"""
        # Note to self: don't move the close()!  Asynchronous servers shouldn't
        # call close() from finish_response(), so if you close() anywhere but
        # the double-error branch here, you'll break asynchronous servers by
        # prematurely closing.  Async servers must return from 'run()' without
        # closing if there might still be output to iterate over.
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
    
    
    def finish_response(self):
        self._write("HTTP/1.1 %s" % self.status)
        
        for header in self.headers:
            self._write("%s: %s" % (header[0], header[1]))
        
        
        self.bytes_sent = 0
        for data in self.result:
            self.bytes_sent = self.bytes_sent + len(data)
        
        self._write("content-length: %s\r\n" % self.bytes_sent)
        self._write("\r\n")
        
        for data in self.result:
            self._write(data)
        
        self.close()
    
    
    def start_response(self, status, headers, exc_info=None):
        """'start_response()' callable as specified by PEP 333"""
        
        if exc_info:
            try:
                if self.headers_sent:
                    # Re-raise original exception if headers sent
                    raise exc_info[0], exc_info[1], exc_info[2]
            finally:
                exc_info = None        # avoid dangling circular ref
        
        
        self.status  = status
        self.headers = headers
        
        return self.write
    
    
    def write(self, data):
        """'write()' callable as specified by PEP 333"""
        pass
    
    
    def _write(self, data):
        print data
        self.stdout.write(data)
    
    
    def _flush(self):
        self.stdout.flush()
    
    
    def close(self):
        """Close the iterable (if needed) and reset all instance vars
    
        Subclasses may want to also drop the client connection.
        """
        try:
            if hasattr(self.result,'close'):
                self.result.close()
        finally:
            self.result = self.headers = self.status = self.environ = None
            self.bytes_sent = 0


    def handle_error(self):
        print sys.exc_info()




class DemoWSGIRequestHandler(DemoHTTPRequestHandler):
    
    def get_environ(self):
        env = self.server.base_environ.copy()
        env['REQUEST_METHOD']  = "GET"
        env['PATH_INFO']       = ""
        env['QUERY_STRING']    = ""
        env['CONTENT_TYPE']    = "html/text"
        env['CONTENT_LENGTH']  = ""
        env['SERVER_PROTOCOL'] = "HTTP/1.1"
        
        return env
    
    
    def get_stderr(self):
        return sys.stderr
    
    def handle(self):
        """Handle a single HTTP request"""
        
        #self.raw_requestline = self.rfile.readline()
        
        handler = DemoWSGIServerHandler(
            self.rfile, self.wfile, self.get_stderr(), self.get_environ()
        )
        handler.request_handler = self      # backpointer for logging
        handler.run(self.server.get_app())





class DemoWSGIServer(DemoHTTPServer):
    
    application = None
    
    
    def server_bind(self):
        DemoHTTPServer.server_bind(self)
        self.setup_environ()
    
    
    def setup_environ(self):
        self.base_environ  = {}
        self.base_environ['SERVER_NAME']       = self.server_name
        self.base_environ['GATEWAY_INTERFACE'] = 'CGI/1.1'
        self.base_environ['SERVER_PORT']       = str(self.server_port)
        self.base_environ['REMOTE_HOST']       = ''
        self.base_environ['CONTENT_LENGTH']    = ''
        self.base_environ['SCRIPT_NAME']       = ''
    
    
    def get_app(self):
        return self.application
    
    
    def set_app(self, application):
        self.application = application





def app_hello_world(environ, start_response):
    start_response('200 OK', [('Content-Type','text/html')])
    
    return ['<html><body><h1>hello world!</h1></body></html>']



def app_show_environ(environ, start_response):
    start_response('200 OK',[('Content-type','text/html')])
    
    sorted_keys = environ.keys()
    sorted_keys.sort()
    
    result = []
    result.append('<html><body><h1>keys-values of environ:</h1>')
    
    for key in sorted(environ.keys()):
        result.append("<p>%s = %s </p>" % (key, environ[key]))
    
    result.append('</body></html>')
    
    return result



if __name__ == "__main__":
    
    http_server = DemoWSGIServer(("0.0.0.0", 8888), DemoWSGIRequestHandler)
    #http_server.set_app(app_hello_world)
    http_server.set_app(app_show_environ)
    http_server.serve_forever()
    
    







