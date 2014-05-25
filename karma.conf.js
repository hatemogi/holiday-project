module.exports = function(config) {
  config.set({
    basePath: 'public/',
    frameworks: ['jasmine', 'requirejs'],
    files: [
      'js/require.min.js',
      'bower_components/jquery/dist/jquery.min.js',
      'spec/karma_mode.js',
      'js/app.js',
      {pattern: 'bower_components/**/*.js', included: false},
      {pattern: 'bower_components/**/*.map', included: false},
      'spec/*Spec.js'
    ],
    exclude: [],
    preprocessors: {},
    reporters: ['progress'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ['Chrome'],
    singleRun: false
  });
};