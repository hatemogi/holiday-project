spawn = require("child_process").spawn
fs = require("fs")

describe 'graphviz', ->
  it '실행해보기', (done) ->
    dot = spawn('dot', ['-Tsvg'], {stdio: 'pipe'})
    dot.on 'error', (data) ->
      done("dot 실행실패: #{data}")
    dot.on 'close', (code) ->
      if (code == 0)
        done()
      else
        done("exit code = #{code}")
    dot.stdout.on 'data', (data) ->
      fs.open "public/output.svg", "w", (err, fd) ->
        fs.write(fd, data.toString())
        fs.close(fd)
    dot.stdin.write "digraph G { 한글 -> t -> p;}"
    dot.stdin.end()

