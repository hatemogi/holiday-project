require 'rugged'
require 'json'

commits = {}
branches = {}

repo = Rugged::Repository.new('git/nodegit.git')
# repo = Rugged::Repository.new('git/angular.js/.git')

walker = Rugged::Walker.new(repo)
walker.sorting Rugged::SORT_TOPO
walker.push(repo.ref("refs/heads/master").target)
branches['master'] = walker.collect do |commit|
  key = commit.oid[0..7]
  changes = 1
  if commit.parents.size == 1
    diff = repo.diff(commit, commit.parents.first)
    changes += diff.patches.collect(&:changes).reduce {|r, c| r + c}
  end
  commits[key] = {
    sha: commit.oid,
    message: commit.message,
    author: commit.author,
    parents: commit.parents.collect {|p| p.oid[0..7]},
    change_level: [3, Math.log(changes)].max
  }
  key
end
walker.reset

puts({commits: commits, branches: branches}.to_json)
