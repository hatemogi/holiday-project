module.exports = (grunt) ->
  js_files = ['app.js', 'lib/*.js', 'public/js/app.js']

  grunt.initConfig {
    pkg: grunt.file.readJSON('package.json')

    coffee: {
      compile: {
        options: {
          sourceMap: true
        }
        files: {
          "public/js/app.js": ['public/assets/app.js.coffee']
        }
      }
    }

    uglify: {
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
    }

    watch:  {
      coffee: {
        files: ["public/assets/*.coffee"]
        tasks: ["coffee", "uglify"]
      }
      jshint: {
        files: js_files
        tasks: ["jshint"]
      }
    }

    jshint: {
      all: js_files
    }
  }

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jshint'

  grunt.registerTask 'default', ['concat', 'coffee', 'uglify']
    