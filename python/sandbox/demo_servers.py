# -*- coding: utf-8 -*-

import socket
import select


class DemoRequestHandler:
    rbufsize = -1
    wbufsize = 0

    def __init__(self, request, client_address, server):
        self.request        = request
        self.client_address = client_address
        self.server         = server
        
        self.connection     = self.request
        
        print self, request, client_address, server
        
        self.rfile = self.connection.makefile('rb', self.rbufsize)
        self.wfile = self.connection.makefile('wb', self.wbufsize)
        
        
        self.raw_requestline = self.rfile.readline(65537)
        
        self.command         = self.raw_requestline.split('\r\n')[0]
        self.path            = self.raw_requestline.split('\r\n')[1]
        self.request_version = self.raw_requestline.split('\r\n')[2]
        
        
        print self.raw_requestline
        
        
        
        
        
        self.wfile.write("Hello World")
        
        self.finish()

    def finish(self):
        if not self.wfile.closed:
            self.wfile.flush()
        self.wfile.close()
        self.rfile.close()
        print "done"





class DemoTCPServer:

    def __init__(self, server_address, RequestHandlerClass):
        
        self.server_address      = server_address # e.g. ("127.0.0.1", 8080)
        self.RequestHandlerClass = RequestHandlerClass
        
        self.__shutdown_request  = False
        
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        
        self.socket.bind(self.server_address)
        self.socket.listen(5)
        
        


    def serve_forever(self, poll_interval=0.5):
        try:
            while not self.__shutdown_request:
                r, w, e = select.select([self.socket], [], [], poll_interval)
                if self.socket in r:
                    self._handle_request_noblock()
        finally:
            self.__shutdown_request = False


    def shutdown(self):
        self.__shutdown_request = True



    def _handle_request_noblock(self):
        request, client_address = self.socket.accept()
        
        print self, request, client_address
        
        self.RequestHandlerClass(request, client_address, self)
        
        request.close()







if __name__ == "__main__":
    import time
    
    tcp_server = DemoTCPServer(("0.0.0.0", 8888), DemoRequestHandler)
    
    tcp_server.serve_forever()
    













