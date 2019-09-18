package demo;

class Main {
  static function main() {
    // Configure our HTTP server to respond with Hello World to all requests.
    var server = js.node.Http.createServer(function(request, response) {
        var url = new js.node.url.URL(request.url,"http://foo.com");
        
        trace(url.search);
      response.writeHead(200, {"Content-Type": "text/plain"});
      response.end("Hello World\n");
    });

    // Listen on port 8000, IP defaults to 127.0.0.1
    server.listen(8000);

    // Put a console.log on the terminal
    trace("Server running at 127.0.0.1:8000");
  }
}