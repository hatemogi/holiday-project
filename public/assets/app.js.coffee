angular.module("holiday", [])
  .controller "LoginController", () ->
    console.log "LoginController 초기화"
    this.welcome = "환영합니다"
    this
$ () ->
  console.log "app.js.coffee loaded"