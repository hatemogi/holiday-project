---
title: '30일 프로젝트 - 사흘'
kind: article
created_at: 2014-05-09
layout: article
---

나는 30일간의 안식휴가 중이다. 휴가 동안 개인 개발 프로젝트를 진행하고 있고, 오늘은 그 사흘째다. 

[첫날]과 [어제]는, 클라이언트 측과 서버사이드에서의 자바스크립트 테스팅 환경을 구축했다. 하나 더 테스트를 위해 고려할만한 사항이 있다면, 이것을 유닛테스트라고 부르든 통합테스트라고 부르든, [express]로 제공할 HTTP 요청에 대한 테스트 환경도 준비해보고자 한다. 일일이 HTTP 요청을 별도로 보내 보는 것이 아니라, 가짜(mock) 요청을 테스팅 프레임워크 수준에서 보내보고 결과를 확인하는 일이다. 

express의 모태인 Ruby [Sinatra의 경우 Rack::Test를 사용해서 했던 일](http://www.sinatrarb.com/testing.html)이다. express 사이트에 테스트는 어떻게 하는지 설명이 있을 거라고 예상했는데, 아쉽게도 찾지 못했다. 프레임워크나 사이트의 철학이 최소한의 기능과 설명을 추구하고 있는 듯하고, HTTP요청 수준의 테스팅은 고려하고 있지 않나 보다. 아니면, 알아서 잘 찾아 쓰라는 마인드인가? 

하는 수 없이, 구글링을 조금 해보니, 별도로 [supertest]라고 잘 준비된 프레임워크가 있었다. [README](https://github.com/visionmedia/supertest#readme) 문서를 훑어보니 한눈에 쏙 들어오는 예제코드가 마음에 띄었다. 

OK, 더 찾아보지 않고 이것으로 낙찰!

[express-generator](https://github.com/expressjs/generator)로 만든 [연습 프로젝트](https://github.com/hatemogi/karma-practice)의 [app.js](https://github.com/hatemogi/karma-practice/blob/master/app.js)에 해당 테스트 코드를 붙여보았다. 


### express 기본 템플릿 

테스트할 소스는 app.js에서 결국 읽어 들이는 [routes/index.js](https://github.com/hatemogi/karma-practice/blob/master/routes/index.js)파일이고, 내용은 아래와 같다.

```javascript
var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res) {
  res.render('index', { title: 'Express' });
});

module.exports = router;
```

중간의 3줄이 핵심인데, ```GET /```요청이 왔을 때, ```index```템플릿을 렌더링할 것이며, ```title```에는 ```Express```라는 값을 바인딩 해서 하겠다는 뜻이다. 렌러링하고자하는 뷰 템플릿은 ```views/index.jade```파일을 읽어서 처리하며, 그 내용은 아래와 같다.

```jade
extends layout

block content
  h1= title
  p Welcome to #{title}
```

이 [jade] 파일이 html로 변환돼 출력되고, 그 때 title 변수에는 ```Express```가 들어있다. 여기까지는 [express-generator]로 기본 생성한 코드이고, 여기서부터 추가로 테스트 코드를 작성했다.

### ```GET /``` 테스트코드 추가

```bash
npm install supertest --save-dev
```

위와 같이 [supertest]를 현재 프로젝트에 설치했다. (참고로 ```--save-dev``` 옵션을 지정하면, 현재 프로젝트의 ```package.json```에 devDependencies에 해당 모듈이 자동 추가된다.)

#### [spec/app_spec.js](https://github.com/hatemogi/karma-practice/blob/master/spec/app_spec.js)

```javascript
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
```

supertest에 준비된 메소드 ```request```로 가짜 (1) ```get('/')``` 요청을 보내보고, 그 결과로 (2) ```Content-Type``` 헤더에는 ```html```이 들어있는지, (3) 결과 HTTP Status Code는 ```200```이 잘 찍혔는지, (4) 응답본문(response body)에는 ```Express```라는 문구가 잘 들어있는지 확인한 뒤, 에러 여부에 따라 ```done()```이나 ```done(err)```를 호출해서 jasmine이 테스트코드 성패 여부를 알 수 있게 한다. 

이렇게 해서 ```jasmine-node```로 테스트를 돌려본 결과는 아래와 같다.

```bash
$ jasmine-node --verbose spec
GET / 200 188ms - 170b

express 앱 - 218 ms
    GET / - 218 ms

자스민 써보기 - 1 ms
    contains text property - 1 ms

Finished in 0.221 seconds
2 tests, 1 assertion, 0 failures, 0 skipped
```

[어제] 작성한 ```자스민 써보기``` 테스트케이스도 문제없이 잘 돌았고, 오늘 작성한 ```express 앱의 GET /```테스트케이스 또한 문제없이 통과 했다. 

참고로, 작성하는 예제 프로젝트는

> <https://github.com/hatemogi/karma-practice>

에 올려놓고 있다. 

오늘은 여기까지, 모두 행복한 불금 되시길!

[첫날]: /holiday-project-day-01/
[어제]: /holiday-project-day-02/
[supertest]: https://github.com/visionmedia/supertest
[Karma]: http://karma-runner.github.io/
[Jasmine]: http://jasmine.github.io/
[express]: http://expressjs.com/
[mocha]: http://visionmedia.github.io/mocha/
[vows]: http://vowsjs.org/
[expresso]: http://visionmedia.github.io/expresso/
[should.js]: https://github.com/visionmedia/should.js
[nodeunit]: https://github.com/caolan/nodeunit
[jasmine-node]: https://github.com/mhevery/jasmine-node
[jade]: http://jade-lang.com/