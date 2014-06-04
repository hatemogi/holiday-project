spawn = require("child_process").spawn
assert = require("assert")
###
dot - "hierarchical" or layered drawings of directed graphs. This is the default tool to use if edges have directionality.

neato - "spring model'' layouts.  This is the default tool to use if the graph is not too large (about 100 nodes) and you don't know anything else about it. Neato attempts to minimize a global energy function, which is equivalent to statistical multi-dimensional scaling.

fdp - "spring model'' layouts similar to those of neato, but does this by reducing forces rather than working with energy.

sfdp - multiscale version of fdp for the layout of large graphs.

twopi - radial layouts, after Graham Wills 97. Nodes are placed on concentric circles depending their distance from a given root node.

circo - circular layout, after Six and Tollis 99, Kauffman and Wiese 02. This is suitable for certain diagrams of multiple cyclic structures, such as certain telecommunications networks.
###

module.exports = {
  supported_engines: ['dot', 'neato', 'fdp', 'sfdp', 'twopi', 'circo']
  run: (engine, dotString, callback) ->
    assert(this.supported_engines.indexOf(engine) >= 0, "지원하지 않는 엔진: #{engine}")
    dot = spawn(engine, ['-Tsvg'], {stdio: 'pipe'})
    result = []
    result_err = []
    dot.stdout.setEncoding 'binary'
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