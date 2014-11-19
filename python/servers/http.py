# -*- coding: utf-8 -*-

#===============================================================================
# This is a demo HTTP Server based on the demo TCP server.
#===============================================================================


from tcp import DemoTCPRequestHandler, DemoTCPServer


class DemoHTTPRequestHandler(DemoTCPRequestHandler):
    
    def parse_request(self):
        self.request_method  = self.raw_request.split("\r\n")[0].split(' ')[0]
        self.path_info       = self.raw_request.split("\r\n")[0].split(' ')[1]
        self.server_protocol = self.raw_request.split("\r\n")[0].split(' ')[2]
    
    
    def handle(self):
        """Handle a single HTTP request"""
        self.parse_request()
        
        
        html = """<!DOCTYPE html>
        <html>
            <head><title>Demo HTTP Server</title></head>
            <body>
                <h1>Hello World!</h1>
                <p><strong>All information of this request:</strong></p>
                <p>%s</p>
            </body>
        </html>
        """ % (self.raw_request.replace("\r\n", "<br />"))
        
        
        ###### response status ######
        self.wfile.write("HTTP/1.1 200 OK")
        
        
        ###### response header ######
        self.wfile.write("Content-Type: text/html;charset=utf-8\r\n")
        self.wfile.write("Content-Length: %s\r\n" % len(html))
        
        self.wfile.write("\r\n")
        
        
        ###### response message ######
        self.wfile.write(html)



class DemoHTTPServer(DemoTCPServer):
    pass



if __name__ == "__main__":
    
    http_server = DemoHTTPServer(("0.0.0.0", 8888), DemoHTTPRequestHandler)
    http_server.serve_forever()














