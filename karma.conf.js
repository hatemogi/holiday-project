module.exports = function(config) {
  config.set({
    basePath: 'public/',
    frameworks: ['jasmine', 'requirejs'],
    files: [
      'bower_components/angular/angular.min.js',
      'bower_components/angular-route/angular-route.js',
      'bower_components/angular-mocks/angular-mocks.js',
      'js/app.js',
      'js/require.min.js',
      'js/init.js',
      {pattern: 'bower_components/**/*.js', included: false},
      {pattern: 'bower_components/**/*.map', included: false},
      {pattern: 'spec/*_spec.js', included: false}
    ],
    exclude: [],
    preprocessors: {

    },
    reporters: ['progress'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ['Chrome'],
    singleRun: false
  });
};