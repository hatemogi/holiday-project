app = require("../app")
request = require("supertest")

describe "express 앱", ->
  it "GET /", (done) ->
    request(app).get("/")
      .expect("Content-Type", /html/)
      .expect(200)
      .expect(/30일 프로젝트/)
      .end done
  it "GET /d3", (done) ->
    request(app).get("/d3")
      .expect("Content-Type", /html/)
      .expect(200)
      .expect(/svg/)
      .end done

