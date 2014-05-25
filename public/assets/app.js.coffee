require_conf = {
  baseUrl: '/'
  paths: {
    jquery: "bower_components/jquery/dist/jquery.min"
    bootstrap: "bower_components/bootstrap/dist/js/bootstrap.min"
    angular: "bower_components/angular/angular.min"
    d3: "bower_components/d3/d3.min"
  }
  shim: {
    angular: {
      exports: "angular"
      deps: ["jquery"]
    }
    bootstrap: {
      exports: "bootstrap"
      deps: ["jquery"]
    }
  }
}

require_conf.baseUrl = 'base/' if KARMA_MODE?

require.config require_conf

require ['angular', 'jquery', 'bootstrap'], (ng, $, bootstrap) ->
  ng.module("holiday", [])
    .controller "LoginCtrl", () ->
      this.welcome = "환영합니다"
      this
  ng.element(document).ready () -> 
    ng.bootstrap(document, ['holiday']);
    $ () ->
      console.log "app.js.coffee loaded"
