nodegit = require("nodegit")
async = require("async")
_ = require("underscore")

nodegitPath = ".git/modules/git/nodegit/"

describe '[CoffeeScript w/async.js] nodegit 저장소', () ->
  it '열어서 커밋 찾아보기', (done) ->
    sha = "e9ec116a8fb2ea051a4c2d46cba637b3fba30575"
    open = nodegit.Repo.open
    async.waterfall [
      open.bind(open, nodegitPath)
      (repo, cb) ->
        expect(repo.path()).toMatch /\/git\/nodegit\/$/
        repo.getCommit sha, cb
      (entry, cb) ->
        expect(entry.sha()).toEqual sha
        cb null
    ], done

  it 'diff 실행해보기', (done) ->
    async.waterfall [
      (cb) ->
        nodegit.Repo.open nodegitPath, cb
      (repo, cb) ->
        async.parallel [
          repo.getCommit.bind(repo, "33c7b930acc13148ef6f05df56f9b8a5c3578a57"),
          repo.getCommit.bind(repo, "c3e4be4448d2a99917431d3be972ca262805f989")
        ], (err, commits) -> cb(err, repo, commits)
      (repo, commits, cb) ->
        async.parallel [
          repo.getTree.bind(repo, commits[0].treeId()),
          repo.getTree.bind(repo, commits[1].treeId())
        ], cb
      (trees, cb) ->
        trees[0].diff trees[1], cb
      (diff, cb) ->
        expect(_.reduce(diff.patches(), ((m, p) -> m + p.size()), 0)).toBe(2)
        cb null
    ], done