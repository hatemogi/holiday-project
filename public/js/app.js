(function() {
  var require_conf;

  require_conf = {
    baseUrl: '/',
    paths: {
      jquery: "bower_components/jquery/dist/jquery.min",
      bootstrap: "bower_components/bootstrap/dist/js/bootstrap.min",
      angular: "bower_components/angular/angular.min",
      d3: "bower_components/d3/d3.min",
      underscore: "js/underscore.min"
    },
    shim: {
      angular: {
        exports: "angular",
        deps: ["jquery"]
      },
      bootstrap: {
        exports: "bootstrap",
        deps: ["jquery"]
      }
    }
  };

  if (typeof KARMA_MODE !== "undefined" && KARMA_MODE !== null) {
    require_conf.baseUrl = 'base/';
  }

  require.config(require_conf);

  require(['angular', 'jquery', 'bootstrap'], function(ng, $, bootstrap) {
    ng.module("holiday", []).controller("LoginCtrl", function() {
      this.welcome = "환영합니다";
      return this;
    });
    return ng.element(document).ready(function() {
      ng.bootstrap(document, ['holiday']);
      return $(function() {
        return console.log("app.js.coffee loaded");
      });
    });
  });

}).call(this);

//# sourceMappingURL=app.js.map
