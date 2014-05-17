git = require('nodegit')
async = require('async')
_ = require('underscore')

async.waterfall [
  (cb) ->
    git.Repo.open 'git/nodegit.git', cb
  (repo, cb) ->
    repo.getReferences 1, cb
  (ref) ->
    heads = /^refs\/(heads|tags)\/(.+)$/
    _.select(ref, (r) -> r.match(heads)).forEach (r) ->
      m = r.match(heads)
      # console.log [m[1], m[2]]
]

commits = {}
branches = {}

async.waterfall [
  (cb) ->
    git.Repo.open 'git/nodegit.git', cb
  (repo, cb) ->
    repo.getMaster cb
  (branch) ->
    history = branch.history(git.RevWalk.Sort.Topological)
    branches["master"] ||= []
    history.on 'commit', (commit) ->
      parents = _.map(commit.parents(), (c) -> c.sha().substr(0,8))
      key = commit.sha().substr(0, 8)
      c = {
        sha: commit.sha()
        message: commit.message()
        author: commit.author
        parents: parents
      }
      console.err commit.diff()
      branches["master"].push key
      commits[key] = c
    history.on 'end', (r) ->
      console.log JSON.stringify({commits: commits, branches: branches})      
    history.start()
]

