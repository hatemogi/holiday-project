describe '[CoffeeScript] nodegit 저장소', () ->
  Repo = require("nodegit").Repo

  it '열어서 커밋 찾아보기', (done) ->
    Repo.open "git/nodegit", (err, repo) ->
      return done(err) if err
      expect(repo.path()).toMatch /\.git\/$/
      sha = "e9ec116a8fb2ea051a4c2d46cba637b3fba30575"
      repo.getCommit sha, (err, entry) ->
        return done(err) if err
        expect(entry.sha()).toEqual sha    
    done()
