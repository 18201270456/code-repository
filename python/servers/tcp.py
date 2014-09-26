# -*- coding: utf-8 -*-

import socket
import select


class DemoTCPRequestHandler:
    rbufsize = -1
    wbufsize = 0

    def __init__(self, request, client_address, server):
        self.request        = request
        self.client_address = client_address
        self.server         = server
        
        self.rfile = self.request.makefile('rb', self.rbufsize)
        self.wfile = self.request.makefile('wb', self.wbufsize)
        
        
        self.raw_request = ""
        while True:
            data = self.rfile.readline(65537)
            
            if data == "\r\n" or data == "":
                break
            
            self.raw_request = "%s%s" % (self.raw_request, data)
        
        
        try:
            self.handle()
        finally:
            self.finish()
    
    
    def handle(self):
        print self.raw_request
        self.wfile.write(self.raw_request)
    
    
    def finish(self):
        if not self.wfile.closed:
            self.wfile.flush()
        
        self.wfile.close()
        self.rfile.close()





class DemoTCPServer:

    def __init__(self, server_address, RequestHandlerClass):
        self.server_address      = server_address #e.g. ("127.0.0.1", 8080)
        self.RequestHandlerClass = RequestHandlerClass
        
        self.__shutdown_request  = False
        
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        
        self.server_bind()
        self.server_activate()
        
    
    
    def serve_forever(self, poll_interval=0.5):
        try:
            while not self.__shutdown_request:
                r, w, e = select.select([self.socket], [], [], poll_interval)
                if self.socket in r:
                    self._handle_request_noblock()
        finally:
            self.__shutdown_request = False
    
    
    def server_bind(self):
        self.socket.bind(self.server_address)
        
        self.server_address = self.socket.getsockname()
        self.server_name    = socket.getfqdn(self.server_address[0])
        self.server_port    = self.server_address[1]
    
    
    def server_activate(self):
        self.socket.listen(5)
    
    
    def shutdown(self):
        self.__shutdown_request = True
    
    
    def _handle_request_noblock(self):
        request, client_address = self.socket.accept()
        
        self.RequestHandlerClass(request, client_address, self)
    







if __name__ == "__main__":
    
    tcp_server = DemoTCPServer(("0.0.0.0", 8888), DemoTCPRequestHandler)
    tcp_server.serve_forever()
    
    ### Use Chrome/Firefox to browse "http://127.0.0.1:8888" will get the text reply from TCP server. ###













