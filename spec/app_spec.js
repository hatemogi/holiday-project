var app = require('../app');
var request = require('supertest')

describe('express 앱', function() {
  it('GET /', function(done) {
    request(app)
      .get('/')
      .expect('Content-Type', /html/)
      .expect(200)
      .expect(/Express/)
      .end(function (err, res) {
        if (err) done(err);
        done();
      });
  });
});