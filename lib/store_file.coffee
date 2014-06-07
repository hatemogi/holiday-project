gvid = require("./gvid")
fs = require("fs")
async = require("async")

store = {
  _ROOT: fs.realpathSync(__dirname + "/../store")
  filename: (id, ext = ".gv") -> "#{store._ROOT}/#{id}#{ext}"
  save_source: (meta, dot, callback, id_gen) ->
    for _ in [0..10]
      id = (id_gen || gvid)()
      filename = store.filename(id)
      continue if fs.existsSync(filename)
      metaJSON = JSON.stringify(meta)
      async.parallel [
        (cb) -> fs.writeFile(filename, dot, cb)
        (cb) -> fs.writeFile(store.filename(id, '.meta'), metaJSON, cb)
      ], (err) ->
        callback(err, id)
      return
    cb("could not generate proper gvid")

  exists_source: (id) ->
    fs.existsSync store.filename(id)

  load_source: (id, callback) ->
    return cb("not exists") unless store.exists_source(id)
    async.parallel [
      (cb) -> fs.readFile(store.filename(id, '.meta'), cb)
      (cb) -> fs.readFile(store.filename(id), cb)
    ], (err, res) ->
      callback(err, JSON.parse(res[0].toString()), res[1].toString())
}

module.exports = store