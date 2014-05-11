---
title: '30일 프로젝트 - 닷새'
kind: article
created_at: 2014-05-11
layout: article
---

나는 30일간의 안식휴가 중이다. 휴가 동안 개인 개발 프로젝트를 진행하고 있고, 오늘은 그 닷새째다. 

어제까지 기본적인 웹 브라우저 측과 서버 측의 테스트 환경을 구축하고 웹 패키지 매니저 [bower]의 기본 사용법을 구축했다. 개인 블로그에 일지를 적다 보니, 소스코드가 아무런 색상 없이 밋밋하게 보이는 것이 눈에 걸렸다. 당장 쓰임새가 있는 주제는 아닌데, 종종 필요로 하는 주제고, 당장 이 일지에 필요하다고 여겨서, 오늘은 소스 코드에 문법 색상을 적용해서 보이는 방법을 연습해보기로 한다. 

정확한 용어는 아마도 [문법 하이라이팅(Syntax Highlighting)](http://en.wikipedia.org/wiki/Syntax_highlighting)일테고, 텍스트 편집기나 IDE 등에서는 Color Scheme이나 Color Theme을 지정해서 보이는 문법에 따른 색상 기능이라고 보면 될 것 같다. 콩글리시로 한다면 ```코드 컬러링```쯤 되려나? 

수년 전이라면, 이런 기능은 서버 측에서 처리해서 HTML로 만든 결과를 HTTP 응답에 넣는 것이 당연한 일이었던 것 같다. 자바스크립트로 만든 코드 하이라이터가 마땅히 없었을뿐더러, 웹서비스의 상식은 서버에서 많은 일을 처리하고, 클라이언트에는 HTML 텍스트만을 돌려주는 것이 기본이었으니까 말이다. 

하지만, 세상이 바뀐 지 오래라, 자바스크립트로 잘 만들어진 코드 하이라이터도 있고, 웹 브라우저의 JS 엔진 성능도 매우 뛰어나고, 사용자의 데스크톱이나 랩톱이, 웬만한 일반(commodity)서버의 성능에 뒤지지 않는데, 굳이 그걸 서버에서 처리할 필요가 없는 상황이다. (실제로, 흥미롭게도, 회사에서 우리 팀이 주로 사용하는 서버 가상머신(VM)의 CPU core 1개의 성능은, 내가 쓰는 맥북프로의 코어 1개 성능에 못 미친다. 게다가 코어 개수도 맥북프로가 훨씬 많다.) 

아무튼, 서버사이드에서 처리한다면 [Pygments]가 대표적이고, 클라이언트사이드에서 처리한다면 [google-code-prettify]와 [highlight.js]가 대표적이다. highlight.js는, 이름으로 예상할 수 있듯, 웹 브라우저에서뿐만 아니라 node.js 환경에서도 쓸 수 있어서, 클라이언트/서버사이드 양측 모두 사용할 수 있다.

예전에, [google-code-prettify]를 써본 적이 있어서, 오늘은 [highlight.js]를 써보기로 한다. 딱히 google-code-prettify에 불만이 있는 것은 아니고, 단지 다른 것을 써보고자 하는 학습의욕이 들었고, node.js환경에서 쓰기 좋다는 점이 다음에 요긴하게 쓸 수 있을 것 같다는 생각이 들었기 때문이다. 

두 패키지 모두 어제 알아본 [bower]로 설치할 수 있다. 

```bash
bower install google-code-prettify --save
bower install highlightjs --save
```

위와 같이 설치한 뒤 highlight.js를 쓰려면 ```bower_components/highlightjs```에 필요한 JS 파일과 각종 컬러 씸(color theme) CSS 파일이 있으니, 마음에 드는 스타일을 적용해 쓴다. 

참고로, 아래 페이지에서 언어별, 그리고 스타일별 색상을 미리 볼 수 있다. 

> <http://highlightjs.org/static/test.html>


스타일도 결정했다면, JS 파일과 CSS 파일을 아래와 같이 사용하고, 마지막 줄의 초기화 명령어도 넣어둔다. 

```html
 <link href="/bower_components/highlightjs/tomorrow.css" rel="stylesheet" type="text/css">
 <script src="/bower_components/highlightjs/highlight.pack.js" type="text/javascript"></script>
 <script>hljs.initHighlightingOnLoad();</script>
```

위와 같이 쓰면, HTML 문서 본문에 있는 ```pre``` 태그와 ```code``` 태그를 모두 찾아서, 자동으로 인식한 언어 문법으로 하이라이트 처리를 해준다. 언어를 명시하고 싶다면, ```class``` 속성에 ```lang-json``` 등을 지정하면 된다. 

```html
 <pre class="lang-json">
   {
     "directory": "public/bower_components"
   }
 </pre>
```

이런 식으로 말이다. 반대로, 하이라이팅을 원하지 않는다면, ```class="no-highlight"```로 지정한다.

마지막으로, 문법 하이라이팅을 적용한 코드와 그렇지 않은 코드를 대조해본다. 

#### pre class="no-highlight"
```no-highlight
var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res) {
  res.render('index', { title: 'Express' });
});

module.exports = router;
```

#### pre class="lang-js"
```js
var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res) {
  res.render('index', { title: 'Express' });
});

module.exports = router;
```

이상으로, [highlight.js]를 이용해서 문법 하이라이팅 기능을 적용해 보았다. 참고로, 이 개인 블로그도 오늘 highlight.js를 적용했다. 

오늘은 여기까지.



[highlight.js]: http://highlightjs.org/
[google-code-prettify]: https://code.google.com/p/google-code-prettify/
[Pygments]: http://pygments.org/
[bower]: http://bower.io/
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

