describe 'Store (File)', ->
  store = require("../lib/store_file")
  gvid = require("../lib/gvid")
  async = require("async")

  it 'save & load source', (done) ->
    meta = {layout: 'dot', seed: Math.random()}
    dot = "digraph { A-> B#{Math.floor(Math.random() * 100)} }"
    async.waterfall [
      (cb) ->
        store.save_source meta, dot, cb
      (id, cb) ->
        expect(gvid.match(id)).toBeTruthy()
        expect(store.exists_source(id)).toBeTruthy()
        store.load_source(id, cb)
      (m, d, cb) ->
        expect(d).toEqual dot
        expect(m).toEqual meta
        cb()
    ], done
