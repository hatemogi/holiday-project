module.exports = function(config) {
  config.set({
    basePath: 'public/',
    frameworks: ['jasmine', 'requirejs'],
    files: [
      'js/require.min.js',
      'js/app.js',
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