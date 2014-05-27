nodegit = require("nodegit")
Promise = require("promise")
_ = require("underscore")

nodegitPath = ".git/modules/git/nodegit/"

openRepo = Promise.denodeify(nodegit.Repo.open)
getCommit = (repo) ->
  Promise.denodeify(repo.getCommit.bind(repo))

describe '[CoffeeScript w/promise.js] nodegit 저장소', () ->
  it '열어서 커밋 찾아보기', (done) ->
    sha = "e9ec116a8fb2ea051a4c2d46cba637b3fba30575"
    openRepo(nodegitPath).then((repo) ->
      expect(repo.path()).toMatch /\/git\/nodegit\/$/
      getCommit(repo)(sha)
    ).then((entry) ->
      expect(entry.sha()).toEqual sha
    ).then(done)
