express = require "express"
router = express.Router()

router.get "/", (req, res) ->
  res.render "d3",
    title: "D3.js 연습"

module.exports = router
