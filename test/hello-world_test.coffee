chai = require "chai"
sinon = require "sinon"
chai.use require "sinon-chai"

expect = chai.expect

describe "principles", ->
  principle_module = require("../src/principles")

  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()
    @msg =
      send: sinon.spy()
      random: sinon.spy()
    @principle = principle_module(@robot)

  describe "Single reply", ->

    it "registers a respond listener", ->
      expect(@robot.respond).to.have.been.calledWith(/principle.*me/)

    it "should send only one line of text", ->
      cb = @robot.respond.firstCall.args[1]
      cb(@msg)
      expect(@msg.send).to.not.have.been.calledWithMatch(/\n/)


  describe "Bomb", ->

    it "registers a respond listener", ->
      expect(@robot.respond).to.have.been.calledWith(/principle.*bomb/)

    it "should send several lines of text", ->
      cb = @robot.respond.secondCall.args[1]
      cb(@msg)
      expect(@msg.send).to.have.been.calledWithMatch(/\n/)
