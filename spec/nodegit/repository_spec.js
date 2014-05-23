nodegitPath = ".git/modules/git/nodegit/"
describe('nodegit 저장소', function() {
  var Repo = require("nodegit").Repo;

  it('열어서 커밋 찾아보기', function(done) {
    Repo.open(nodegitPath, function(err, repo) {
      if (err) {
        return done(err);
      }
      expect(repo.path()).toMatch(/\.git\/$/);

      var sha = "e9ec116a8fb2ea051a4c2d46cba637b3fba30575";
      repo.getCommit(sha, function(err, entry) {
        if (err) {
          return done(err);
        }
        expect(entry.sha()).toEqual(sha);  
      });
    });

    done();
  });
});
