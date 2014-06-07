express = require "express"
dot_runner = require "../lib/dot_runner"
gvid = require "../lib/gvid"
store = require "../lib/store_file"

router = express.Router()

# GET home page.
router.get "/", (req, res) ->
  res.render "editor"

router.get /\/[0-9A-Z]{5,6}/, (req, res) ->
  console.log "request for #{req.path}"
  id = req.path.replace(/^\//, '')
  return res.send(404) unless gvid.valid(id)
  store.load_source id, (err, meta, dot) ->
    res.render "editor", {meta: meta, dot: dot}

router.post "/dot", (req, res) ->
  engine = req.body.engine || 'dot'
  console.log "engine: #{engine}"
  dot_runner.run engine, req.body.text, (err, svg) ->
    # console.log ["result", svg]
    res.end svg

module.exports = router
