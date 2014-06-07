describe 'gvID', ->
  gvid = require("../lib/gvid")

  it '신규발급 테스트', () ->
    for _ in [0..10000]
      id = gvid()
      expect(id.length).toBe(5, "현재 기본 발급은 5자리")
      expect(gvid.match(id)).toBeTruthy("발급한 ID는 정상이어야")

  it '신규발급 1차 중복 확인', (done) ->
    map = {}
    for _ in [0..100]
      id = gvid()
      return done("duplicated") if map[id]
      map[id] = "occupied"
    done()

  it '#match: gvid가 맞는지 확인', () ->
    expect(gvid.match('12345')).toBe true, "12345는 정상"
    expect(gvid.match('')).toBe false, "비어서는 안됨"
    expect(gvid.match()).toBe false, "비어서는 안됨"
    expect(gvid.match('1234')).toBe false, "4자리는 안됨"
    expect(gvid.match('012345')).toBe true, "6자리도 인정"
    expect(gvid.match('1234567')).toBe false, "7자리는 안됨"
    expect(gvid.match('ABCDE')).toBe true, "정상알파벳"
    expect(gvid.match('ABcDE')).toBe false, "소문자는 안됨"
    expect(gvid.match('IBCDE')).toBe false, "I도 안됨"

  it "#normalize: 잘못 표기한것 gvid로 정상화", () ->
    expect(-> gvid.normalize("안좋은ID")).toThrow()
    expect(gvid.normalize("12345")).toEqual "12345"
    expect(gvid.normalize("I23L5")).toEqual "12315"
    expect(gvid.normalize("IO3I5")).toEqual "10315"