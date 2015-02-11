e = require 'expect.js'
request = require 'supertest'
connect = require 'connect'
http = require 'http'
iport = require '../'


describe 'iport', () ->
  before (done)->
    done()

  after (done)->
    done()

  it 'success', (done) ->
    e(1).to.eql(1)
    done()



