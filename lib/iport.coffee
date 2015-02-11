# iport.coffee 
# Author: jifeng.zjd <jifeng.zjd@taobao.com>


exports.middleware = ()->
  (req, res, next)=>
    ip = getIP(req)
    port = getPort(req)

    #现在使用的方式是模拟req.socket._getpeername方法
    #nodejs源码: https://github.com/joyent/node/blob/d8baf8a2a4481940bfed0196308ae6189ca18eee/lib/net.js#L584
    req.socket._getpeername = ()->
    	{ address: ip, port: port }
    next()

exports.getIP = getIP = (req)->
  ip = req.headers['x-forwarded-for'] or  
    (req.connection and req.connection.remoteAddress) or 
    (req.socket and req.socket.remoteAddress) or
    (req.connection and req.connection.socket and req.connection.socket.remoteAddress)
  ip

exports.getPort = getPort = (req)->
  port = req.headers['x-forwarded-for-port'] or  
    (req.connection and req.connection.remotePort) or 
    (req.socket and req.socket.remotePort) or
    (req.connection and req.connection.socket and req.connection.socket.remotePort)
  port
