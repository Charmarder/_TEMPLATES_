var http = require('http');
var url = require('url');
var fs = require('fs');

var dt = require('./1module'); // my oun module

//create a server object:
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
//  res.write("The date and time are currently: " + dt.myDateTime() + '<br><br>');  //write a response to the client
//  res.write(req.url + '<br>');
//  var q = url.parse(req.url, true).query;
//  var txt = q.year + " " + q.month;
//  res.write(txt);

  // read file
  fs.readFile('index.html', function(err, data) {
//    res.writeHead(200, {'Content-Type': 'text/html'});
    res.write(data);
    res.end();
  });

//  res.end(); //end the response
}).listen(8080); //the server object listens on port 8080

