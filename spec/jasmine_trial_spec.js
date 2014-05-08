var jasmine_trial = require('../lib/jasmine_trial');

describe("자스민 써보기", function() {
  it("contains text property", function() {
    expect(jasmine_trial.text()).toBe("자스민 안녕!");
  });
});

