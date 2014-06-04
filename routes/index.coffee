express = require "express"
dot = require "../lib/dot_runner"
router = express.Router()

# GET home page. 
router.get "/", (req, res) ->
  res.render "index",
    title: "Express"

router.post "/dot", (req, res) ->
  engine = req.body.engine || 'dot'
  dot.run engine, req.body.text, (err, svg) ->
    # console.log ["result", svg]
    res.end svg

module.exports = router
