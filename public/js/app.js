(function() {
  angular.module("holiday", []).controller("LoginController", function() {
    console.log("LoginController 초기화");
    this.welcome = "환영합니다";
    return this;
  });

  $(function() {
    return console.log("app.js.coffee loaded");
  });

}).call(this);

//# sourceMappingURL=app.js.map
