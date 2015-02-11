var http = require('http');
var iport = require('iport');
var connect = require('connect');

var app = connect()
app.use(function (req, res, next) {
  res.statusCode = 200;
  //获取ip地址
  var ip = iport.getIP(req);
  //获取port地址
  var port = iport.getPort(req);
  res.end(ip + ':' + port);
});

//按规则通知ip和port的获取
app.use('/normal', iport.middleware());

var server = http.createServer(app);

server.listen(1723);

