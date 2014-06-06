dotRunner = new require("../lib/dot_runner")

describe 'dotRunner', ->
  it 'run 정상 테스트', (done) ->
    dotRunner.run "dot", "digraph G { 한글 -> t -> p;}", (err, data) ->
      if err
        done(err)
      else
        expect(data).toMatch /svg/
        done()
  it 'run 구문 에러 테스트', (done) ->
    dotRunner.run "dot", "digraph G { 한글 -> t -> p;", (err, data) ->
      unless err
        done("에러발생하지 않았음")
      else
        expect(err).toBe(1)
        expect(data).toMatch /syntax error/
        done()
  it '미지원 엔진시 에러처리', () ->
    expect(-> dotRunner.run "not-supported-engine").toThrow()