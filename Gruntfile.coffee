module.exports = (grunt) ->
  js_files = ['app.js', 'lib/*.js', 'public/js/app.js', 'public/spec/*.js']

  grunt.initConfig {
    pkg: grunt.file.readJSON('package.json')

    coffee: {
      app: {
        options: {
          sourceMap: true
        }
        files: {
          "public/js/app.js": ['public/assets/app.js.coffee']
          "public/js/init.js": ['public/assets/init.js.coffee']
        }
      }
    }

    uglify: {
      underscore: {
        options: {
          sourceMap: true
        }
        files: {
          "public/js/underscore.min.js": ["public/bower_components/underscore/underscore.js"]
        }        
      }
      requirejs: {
        options: {
          sourceMap: true
        }
        files: {
          "public/js/require.min.js": ["public/bower_components/requirejs/require.js"]
        }
      }
      app: {
        options: {
          sourceMap: true
          sourceMapIn: 'public/js/app.js.map'
          sourceMapName: 'public/js/app.min.js.map'
        }
        files: {
          "public/js/app.min.js": ["public/js/app.js"]
        }
      }
      init: {
        options: {
          sourceMap: true
          sourceMapIn: 'public/js/init.js.map'
          sourceMapName: 'public/js/init.min.js.map'
        }
        files: {
          "public/js/init.min.js": ["public/js/init.js"]
        }
      }
    }

    watch:  {
      coffee: {
        files: ["public/assets/*.coffee"]
        tasks: ["coffee", "uglify:app", "uglify:init"]
      }
      jshint: {
        files: js_files
        tasks: ["jshint"]
      }
      jasmine_node: {
        files: ["lib/**/*.coffee", "spec/**/*.coffee", "app.coffee", "routes/*.coffee"]
        tasks: ["jasmine_node"] 
      }
      less: {
        files: ["public/assets/*.less"]
        tasks: ["less"]
      }
    }

    jshint: {
      all: js_files
    }

    karma: {
      unit: {
        configFile: 'karma.conf.js'
      }
    }

    jasmine_node: {
      all: ["spec/"]
      options: {
        extensions: ".coffee"
        match: ["."]
        helpers: "spec/helper.coffee"
        coffee: true
      }
    }

    less: {
      all: {
        options: {
          paths: ["public/asset"]
          compress: true
        }
        files: {
          "public/css/editor.css": "public/assets/editor.css.less"
        }
      }
    }
  }

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-jasmine-node'
  grunt.loadNpmTasks 'grunt-contrib-less'

  grunt.registerTask 'test', ['jasmine_node']
  grunt.registerTask 'default', ['coffee', 'uglify', 'less', 'test']