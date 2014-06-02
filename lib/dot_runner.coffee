spawn = require("child_process").spawn

module.exports = {
  run: (dotString, callback) ->
    dot = spawn('dot', ['-Tsvg'], {stdio: 'pipe'})
    result = []
    dot.on 'error', (data) ->
      callback("dot 실행실패: #{data}")
    dot.on 'close', (code) ->
      if (code == 0)
        callback(null, result.join())
      else
        callback("exit code = #{code}")
    dot.stdout.on 'data', (data) ->
      result.push data.toString()
    dot.stdin.write dotString
    dot.stdin.end()
}