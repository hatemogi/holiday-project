dotRunner = new require("../lib/dot_runner")

describe 'dotRunner', ->
  it 'run 테스트', (done) ->
    dotRunner.run "digraph G { 한글 -> t -> p;}", (err, data) ->
      if err
        done(err)
      else
        expect(data).toMatch /svg/
        done()