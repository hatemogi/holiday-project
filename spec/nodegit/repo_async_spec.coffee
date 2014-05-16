nodegit = require("nodegit")
async = require("async")

describe '[CoffeeScript w/async.js] nodegit 저장소', () ->
  it '열어서 커밋 찾아보기', (done) ->
    sha = "e9ec116a8fb2ea051a4c2d46cba637b3fba30575"
    async.waterfall [
      (callback) -> 
        nodegit.Repo.open "git/nodegit", callback
      (repo, callback) ->
        expect(repo.path()).toMatch /\.git\/$/
        repo.getCommit sha, callback
      (entry, callback) ->
        expect(entry.sha()).toEqual sha
        callback null
    ], (err, _result) -> done(err)
