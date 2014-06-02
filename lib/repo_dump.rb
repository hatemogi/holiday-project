require 'rugged'
require 'json'

commits = {}
branches = {}

repo = Rugged::Repository.new('.git')
# repo = Rugged::Repository.new('git/angular.js/.git')

branches = repo.refs.collect do |r|
  {name: r.name, target: r.target}
end

walker = Rugged::Walker.new(repo)
walker.sorting Rugged::SORT_TOPO

branches.each do |r|
  walker.push r[:target]
end
walker.each do |commit| 
  key = commit.oid[0..7]
  changes = 1
  throw "이미 있음" unless commits[key].nil?
  if commit.parents.size == 1
    diff = repo.diff(commit, commit.parents.first)
    changes += diff.patches.collect(&:changes).reduce(0) {|r, c| r + c}
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
# walker.reset

# puts({commits: commits, branches: branches}.to_json)

def track_commits commits, c
  if p = c[:parents]
    p.collect {|p| [c[:sha][0..7], p]} \
    + p.reduce([]) {|r, p| r + track_commits(commits, commits[p])}
  else
    []
  end
end

graphs = {}
branches.each do |r|
  c = commits[r[:target][0..7]]
  graphs[r[:name]] = track_commits commits, c
end

puts "digraph G {"
g = []
graphs.each do |k, v|
  g += v.collect {|p| 
    "  \"#{p[0]}\" -> \"#{p[1]}\"; "
  }
end
puts g.sort.uniq.join("\n")
puts "}"