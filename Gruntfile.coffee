module.exports = (grunt) ->
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
      all: {
        options: {
          sourceMap: true
          sourceMapName: 'public/js/app.min.js.map'
        }
        sourceMap: true
        files: {
          "public/js/app.min.js": ["public/js/app.js"]
        }
      }
    }
  }
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.registerTask 'default', ['coffee', 'uglify']
    