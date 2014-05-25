(function() {
  var require_conf, spec_files;

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
        exports: "angular"
      },
      bootstrap: {
        exports: "bootstrap",
        deps: ["jquery"]
      },
      underscore: {
        exports: "_"
      }
    }
  };

  if (window.__karma__) {
    spec_files = [];
    Object.keys(window.__karma__.files).forEach(function(f) {
      if (/_spec.js$/.test(f)) {
        return spec_files.push(f.replace(/^\/base\//, '').replace(/\.js$/, ''));
      }
    });
    console.log(["테스트 대상", spec_files]);
    require_conf.baseUrl = 'base/';
    require_conf.deps = spec_files;
    require_conf.callback = window.__karma__.start;
  }

  require.config(require_conf);

  require(['angular'], function(ng) {
    ng.module("holiday", []).controller("LoginCtrl", function() {
      this.welcome = "환영합니다";
      return this;
    });
    return ng.element(document).ready(function() {
      return ng.bootstrap(document, ['holiday']);
    });
  });

}).call(this);

//# sourceMappingURL=app.js.map
