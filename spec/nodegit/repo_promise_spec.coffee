nodegit = require("nodegit")
Promise = require("promise")
_ = require("underscore")

nodegitPath = ".git/modules/git/nodegit/"

openRepo = Promise.denodeify(nodegit.Repo.open)
getCommit = (repo) ->
  Promise.denodeify(repo.getCommit.bind(repo))
getTree = (repo) ->
  Promise.denodeify(repo.getTree.bind(repo))
getDiff = (tree) ->
  Promise.denodeify(tree.diff.bind(tree))

describe '[CoffeeScript w/promise.js] nodegit 저장소', () ->
  it '열어서 커밋 찾아보기', (done) ->
    sha = "e9ec116a8fb2ea051a4c2d46cba637b3fba30575"
    openRepo(nodegitPath).then((repo) ->
      expect(repo.path()).toMatch /\/git\/nodegit\/$/
      getCommit(repo)(sha)
    ).then((entry) ->
      expect(entry.sha()).toEqual sha
    ).then done, done

  it 'diff 실행해보기', (done) ->
    openRepo(nodegitPath).then((repo) ->
      Promise.all([
        getCommit(repo)("33c7b930acc13148ef6f05df56f9b8a5c3578a57"),
        getCommit(repo)("c3e4be4448d2a99917431d3be972ca262805f989")
      ]).then((c) ->
        Promise.all [
          getTree(repo)(c[0].treeId()),
          getTree(repo)(c[1].treeId())
        ]
      )
    ).then((trees) ->
      getDiff(trees[0])(trees[1])
    ).then((diff) ->
      patchsize = _.reduce(diff.patches(), ((m, p) -> m + p.size()), 0)
      expect(patchsize).toBe(2)
    ).then done, done