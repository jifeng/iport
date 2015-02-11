e = require 'expect.js'
request = require 'supertest'
connect = require 'connect'
http = require 'http'
iport = require '../'

app = connect()
app.use '/header', (req, res, next)->
  req.headers['x-forwarded-for'] = '172.11.23.1'
  req.headers['x-forwarded-for-port'] = 1987
  next()
app.use iport.middleware()
app.use (req, res, next)->
  res.statusCode = 200
  obj = 
    'connection.remoteAddress': req.connection and req.connection.remoteAddress
    'socket.remoteAddress': req.socket and req.socket.remoteAddress
    'connection.remotePort': req.connection and req.connection.remotePort
    'socket.remotePort': req.socket and req.socket.remotePort
  res.end JSON.stringify(obj)
app = http.createServer app
port = Math.floor(Math.random()* 9000 + 1000)

describe 'iport', () ->
  before (done)->
    app.listen port, done

  after (done)->
    done()

  it 'normal success', (done) ->
    request(app)
    .get('/')
    .expect(200)
    .expect(/connection.remoteAddress":"127.0.0.1"/)
    .expect(/socket.remoteAddress":"127.0.0.1"/)
    .end((err, res, body)->
      e(err).to.equal(null)
      body = JSON.parse res.res.text
      e(typeof body['connection.remotePort']).to.eql('number')
      e(typeof body['socket.remotePort']).to.eql('number')
      e(body['connection.remotePort']).to.eql(body['socket.remotePort'])
      done()
    )


  it 'header success', (done) ->
    request(app)
    .get('/header')
    .expect(200)
    .expect(/connection.remoteAddress":"172.11.23.1"/)
    .expect(/socket.remoteAddress":"172.11.23.1"/)
    .end((err, res, body)->
      e(err).to.equal(null)
      body = JSON.parse res.res.text
      e(typeof body['connection.remotePort']).to.eql('number')
      e(typeof body['socket.remotePort']).to.eql('number')
      e(body['connection.remotePort']).to.eql(body['socket.remotePort'])
      done()
    )


