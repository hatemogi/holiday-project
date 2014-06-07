bases = require('bases')

# 5자리로 발급되는 id는 1/9000 정도로 중복이 발생한다.
# 중복 발생시 재발급 받도록 한다.
gvid = () ->
  start = bases.fromBase32 '10000'
  end = bases.fromBase32 'ZZZZZ'
  range = end - start
  r = Math.floor(Math.random() * range) + start
  bases.toBase32 r

normalizable = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".replace('U', '')
normalizable_re = new RegExp("^[#{normalizable}]{5,6}$")
alphabet = normalizable.replace(/[ILOU]/, '')
re = new RegExp("^[#{alphabet}]{5,6}$")

gvid.valid = (str) ->
  re.test str

# 잘못 표기된 Base32 정상화
gvid.normalize = (str) ->
  str = str.replace(/[IL]/g, "1").replace(/O/g, "0")
  throw "not an gvid" unless gvid.valid(str)
  str

gvid.normalizable = (str) ->
  normalizable_re.test str

module.exports = gvid