require_conf = {
  baseUrl: '/'
  paths: {
    jquery: "bower_components/jquery/dist/jquery.min"
    bootstrap: "bower_components/bootstrap/dist/js/bootstrap.min"
    underscore: "js/underscore.min"
  }
  shim: {
    bootstrap: {
      exports: "bootstrap"
      deps: ["jquery"]
    }
    underscore: {
      exports: "_"
    }
  }
}

# Karma 테스트를 위한 설정
if window.__karma__
  spec_files = []
  Object.keys(window.__karma__.files).forEach (f) ->
    if /_spec.js$/.test(f)
      spec_files.push f.replace(/^\/base\//, '').replace(/\.js$/, '')
  console.log ["테스트 대상", spec_files]
  require_conf.baseUrl = 'base/' 
  require_conf.deps = spec_files
  require_conf.callback = window.__karma__.start

require.config require_conf