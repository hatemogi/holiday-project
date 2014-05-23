nodegit = require("nodegit")
async = require("async")
_ = require("underscore")

nodegitPath = ".git/modules/git/nodegit/"

describe '[CoffeeScript w/async.js] nodegit 저장소', () ->
  it '열어서 커밋 찾아보기', (done) ->
    sha = "e9ec116a8fb2ea051a4c2d46cba637b3fba30575"
    async.waterfall [
      (callback) -> 
        nodegit.Repo.open nodegitPath, callback
      (repo, callback) ->
        expect(repo.path()).toMatch /\/git\/nodegit\/$/
        repo.getCommit sha, callback
      (entry, callback) ->
        expect(entry.sha()).toEqual sha
        callback null
    ], (err, _result) -> done(err)
  it 'diff 실행해보기', (done) ->
    nodegit.Repo.open nodegitPath, (err, repo) ->
      return done(err) if err
      async.waterfall [
        (callback) ->
          sha1 = "33c7b930acc13148ef6f05df56f9b8a5c3578a57"
          sha2 = "c3e4be4448d2a99917431d3be972ca262805f989" #"cfce1e0dae57b00d724bdab47f4f578cdb140d7a"
          repo.getCommit sha1, (err, commit1) ->
            return callback(err) if err
            repo.getCommit sha2, (err, commit2) ->
              callback(null, commit1.treeId(), commit2.treeId())
        (t1, t2, callback) ->
          repo.getTree t1, (err, tree1) ->
            return callback(err) if err
            repo.getTree t2, (err, tree2) ->
              callback(null, tree1, tree2)
        (tree1, tree2, callback) ->
          tree1.diff tree2, callback
        (diff, callback) ->
          expect(_.reduce(diff.patches(), ((m, p) -> m + p.size()), 0)).toBe(2)
          callback null
      ], (err, _result) -> done(err)
