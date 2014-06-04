bases = require('bases')

# An example of a simple pseudo-random number generator is the multiply-with-carry method invented by George Marsaglia. It is computationally fast and has good (albeit not cryptographically strong) randomness properties:[7]

multi_carry = (w, z) ->
  this.w = w || Math.floor(Math.random() * 32767)
  this.z = z || Math.floor(Math.random() * 32767)

  this.next = ()->
    this.z = 36969 * (this.z & 65535) + (this.z >> 16);
    this.w = 18000 * (this.w & 65535) + (this.w >> 16);
    (this.z << 16) + this.w
  this

conflict_space = (rng) ->
  map = {}
  count = 0
  conflict_count = 0
  while true
    r = rng.next()
    map[r] = (map[r] || 0) + 1
    conflict_count += 1 if map[r] > 2
    break if conflict_count >= 1
    count += 1
  count

find_conflict_avg = (start, end, rngClass, msg) ->
  range = end - start
  # console.log "range = #{range}"
  counts = []
  rng = new rngClass(range)
  for i in [0...10]
    counts.push conflict_space(rng)
  avg = counts.reduce((r,c) -> (r || 0) + c) / counts.length
  min = Math.min.apply(Math.min, counts)
  # console.log("#{msg} [#{counts}]: avg = #{avg}, min = #{min}")
  avg  
describe 'base32', ->
  MathRandom = (range) ->
    this.next = () ->
      Math.floor(Math.random() * range)
    this

  MultiCarry = (range) ->
    this.carrier = new multi_carry()
    this.next = () ->
      Math.floor(this.carrier.next() * 1.0 / (1 << 32) * range)
    this
  it 'Math.random 5자리 두번 충돌나는 수 확인', ->
    expect(find_conflict_avg(bases.fromBase32('10000'), bases.fromBase32('ZZZZZ'),MathRandom, "5자리 충돌")).toBeGreaterThan 100000
  it 'Math.random 4자리 두번 충돌나는 수 확인', ->
    expect(find_conflict_avg(bases.fromBase32('1000'), bases.fromBase32('ZZZZ'), MathRandom, "4자리 충돌")).toBeGreaterThan 10000
  
  skip = (-> jasmine.log 'skipped') unless skip?

  skip 'MultiCarry 5자리 두번 충돌나는 수 확인', ->
    find_conflict_avg(bases.fromBase32('10000'), bases.fromBase32('ZZZZZ'),MultiCarry, "MC 5자리 충돌")
  skip 'MultiCarry 4자리 두번 충돌나는 수 확인', ->
    find_conflict_avg(bases.fromBase32('1000'), bases.fromBase32('ZZZZ'), MultiCarry, "MC 4자리 충돌")
  