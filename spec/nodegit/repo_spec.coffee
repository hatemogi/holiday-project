nodegit = require("nodegit")
repoPath = ".git/modules/git/nodegit/"

describe '[CoffeeScript] nodegit 저장소', () ->
  it '열어서 커밋 찾아보기', (done) ->
    sha = "e9ec116a8fb2ea051a4c2d46cba637b3fba30575"
    nodegit.Repo.open repoPath, (err, repo) ->
      return done(err) if err
      expect(repo.path()).toMatch /\/git\/nodegit\/$/
      repo.getCommit sha, (err, entry) ->
        return done(err) if err
        expect(entry.sha()).toEqual sha    
        done()
