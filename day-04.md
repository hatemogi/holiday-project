---
title: '30일 프로젝트 - 나흘'
kind: article
created_at: 2014-05-10
layout: article
---

나는 30일간의 안식휴가 중이다. 휴가 동안 개인 개발 프로젝트를 진행하고 있고, 오늘은 그 나흘째다. 

어제까지는 기본적인 테스트 환경을 구축했다. 절묘하게도 어젯밤 자정, 테스트 환경 준비에 열을 올린 최근에 걸맞은 타이밍으로, "Is TDD Dead?"라는 주제로 온라인 토론회가 진행되었다. 개발자들 사이에 연예인이라고 봐도 무방할 유명인들인 [마틴 파울러(Martin Fowler)](https://twitter.com/@martinfowler), [켄트 벡(Kent Beck)](https://twitter.com/@kentbeck), [데이비드 하이네마이어 한슨(David Heinemeier Hansson)](https://twitter.com/@dhh)이 구글 행아웃으로 모여 각자의 주장을 펼쳤으며, TDD를 창시한 켄트 벡과, 최근 [TDD는 죽었다고 블로깅](http://david.heinemeierhansson.com/2014/tdd-is-dead-long-live-testing.html)한 DHH간의 설전으로 이어지지 않을까 기대했던 이벤트였다. 당연한 얘기지만, 설전이나 공방은 없었고, 각자 나름의 정의와 이해, 그리고 의견을 피력한 시간이었던 것. 그래도, 쟁쟁한 사람들의 나름의 논리를 실시간으로 구경하고 있으니 적지 않은 재미가 있었다. 이벤트가 끝나고, 바로 [녹화분](https://www.youtube.com/watch?v=z9quxZsLcfo)이 올라와서, 뒤늦게라도 다시 볼 수 있다. 다음 주, 같은 시간 (금요일 자정, 토요일 0시)에 또 구글 행아웃으로 이어서 진행한다고 한다.

다시, 원래 개발 프로젝트 얘기로 돌아와서, 오늘은 [bower]를 좀 살펴보기로 했다. bower는 **웹을 위한 패키지 매니저**로, node.js의 npm, ruby의 gem과 마찬가지로, 패키지 관리를 돕는 툴인데, 다른 점이 있다면 웹 환경을 위한 것이라는 점이다. 예를 들어, 개발하는 프로젝트에서 [jQuery]나 [bootstrap]을 쓸 때, 일일이 다운로드 받아서 설치하면, 처음에야 별문제 없지만, 나중에 새 버전이 나와서 업그레이드하고자 할 때에 다시 같은 작업을 손으로 진행해야 한다는 불편함이 있다. ```bower```를 써서 관리한다면, 간단한 커맨드로, 설치도 하고, 업그레이드도 할 수 있으며, 어떤 패키지를 위해 필요한 의존 패키지도 받아서 설치해주므로 편리하게 사용할 수 있다. 

_(물론, bootstrap이나 jQuery등은 공개 CDN에 링크 걸어서 쓰는 게 가장 편리할 수 있다.)_

### [bower] 설치

```bash
npm install -g bower
```

위의 npm 명령어로 bower를 설치하고, 

```json
{
  "directory": "public/bower_components"
}
```

위의 설정을 프로젝트 디렉터리에 ```.bowerrc```라는 파일명으로 저장한다. 기본으로 bower 패키지를 설치하면 프로젝트 디렉터리의 ```bower_components```라는 디렉터리 아래에 저장하는데, 위의 설정 값 파일을 넣어두면, ```public/bower_components```에 저장한다. express에서 정적(static)파일로 바로 사용할 수 있게 하기 좋은 설정이다. 

그런 다음, ```bower init```로 bower.json(패키지 설정 파일)을 생성한다. 터미널에서 몇가지 질문에 답하면 기본 뼈대가 생성되고, 여기에 아래 명령어로 몇 가지 패키지를 설치해봤다.

```bash
bower install bootstrap --save
bower install angular#1.3.0-beta.8 --save
bower install google-code-prettify --save
bower install jasmine --save-dev
```

위의 석 줄은, bootstrap의 최신판과 [angular.js]의 현재 최신 베타버전, 그리고 [google-code-prettify](https://code.google.com/p/google-code-prettify/)를 설치하고, ```--save``` 옵션으로 bower.json의 ```dependencies``` 항목에 추가하는 명령이다. 마지막 줄은 마찬가지 방식으로 jasmine을 설치하되, ```--save-dev``` 옵션으로 ```devDependencies``` 항목에 추가하겠다는 뜻이다. jasmine은 개발환경에서는 쓰겠지만, 프로덕션 환경에 추가될 필요는 없으니, 개발 패키지에만 포함한다. 

그렇게 해서, 만든 ```bower.json```의 내용은 아래와 같다. 

```json
{
  "name": "karma-practice",
  "version": "0.0.1",
  "homepage": "https://github.com/hatemogi/karma-practice",
  "authors": [
    "DaeHyun Kim <hatemogi at gmail.com>"
  ],
  "description": "to learn and practice Karma and Angular.js",
  "license": "MIT",
  "private": true,
  "ignore": [
    "**/.*",
    "node_modules",
    "bower_components",
    "public/bower_components",
    "test",
    "tests"
  ],
  "dependencies": {
    "angular": "1.3.0-beta.8",
    "bootstrap": "~3.1.1",
    "google-code-prettify": "~1.0.1"
  },
  "devDependencies": {
    "jasmine": "~2.0.0"
  }
}
```

이렇게 준비한 ```bower.json```만 git 저장소에 넣어두고, 해당 프로젝트를 새로 클론 받았을 경우에는 ```bower install```명령어 만으로 필요한 패키지들을 내려받을 수 있다. 즉, git 저장소에는 ```public/bower_components```는 넣어 둘 필요 없다.

참고로, 작성하는 예제 프로젝트는

> <https://github.com/hatemogi/karma-practice>

에 올려놓고 있다. 

오늘은 여기까지. 

[angular.js]: http://angularjs.org
[jQuery]: http://jquery.org/
[bootstrap]: http://getbootstrap.com/
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