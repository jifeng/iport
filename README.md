# iport

![logo](https://raw.github.com/jifeng/iport/master/logo.png)

web服务中ip和port的统一公里工具类

## 取名

iport = ip + port

## 安装

```
npm install iport
```

## 用法

```javascript

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

```

### 讲解

- ip和port的获取规则: http headers -> http -> tcp
- headers的默认头信息 `x-forwarded-for` 和 `x-forwarded-for-port`

