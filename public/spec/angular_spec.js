describe('angular 컨텍스트', function() {
  beforeEach(module("holiday"));
  it("버전 확인", inject(function($controller) {
    expect(angular.version).toBeDefined();
    expect(angular.version.full).toEqual("1.3.0-beta.8");
    console.log($controller("LoginCtrl"));
    expect($controller("LoginCtrl").welcome).toEqual("환영합니다");

  }));
});