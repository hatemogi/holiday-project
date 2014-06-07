app = require("../app")
request = require("supertest")

describe "express 앱", ->
  it "GET /", (done) ->
    request(app).get("/")
      .expect("Content-Type", /html/)
      .expect(200)
      .expect(/editor/)
      .end done
  it "GET /d3", (done) ->
    request(app).get("/d3")
      .expect("Content-Type", /html/)
      .expect(200)
      .expect(/svg/)
      .end done
  it 'POST /dot', (done) ->
    body = "digraph G {\n d1 -> d2 -> d3; d1 -> d4; }"
    request(app).post("/dot").send({text: body})
      .expect(200)
      .end done
  it "GET /TEST1 - 소스 읽기", (done) ->
    request(app).get("/TEST1")
      .expect(200)
      .end done