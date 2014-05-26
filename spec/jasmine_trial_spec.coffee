jasmine_trial = require("../lib/jasmine_trial")

describe "자스민 써보기", ->
  it "contains text property", ->
    expect(jasmine_trial.text()).toBe "자스민 안녕!"
