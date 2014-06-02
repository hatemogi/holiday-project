spawn = require("child_process").spawn

module.exports = {
  run: (dotString, callback) ->
    dot = spawn('dot', ['-Tsvg'], {stdio: 'pipe'})
    result = []
    result_err = []
    dot.on 'error', (data) ->
      callback("dot 실행실패: #{data}")
    dot.on 'close', (code) ->
      if (code == 0)
        callback(null, result.join())
      else
        callback(code, result_err.join())
    dot.stdout.on 'data', (data) ->
      result.push data.toString()
    dot.stderr.on 'data', (data) ->
      result_err.push data.toString()
    dot.stdin.end(dotString.toString())
}