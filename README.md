30일간의 Node.js 웹애플리케이션 개발 여행
==================================

[![Build Status](https://travis-ci.org/hatemogi/holiday-project.svg?branch=master)](https://travis-ci.org/hatemogi/holiday-project)

나는 30일간의 휴가 중이다. 휴가 동안 혼자 간단한 웹앱 개발 프로젝트를 진행하고 있고, 아래가 그 일지이다. 그간 관심있게 눈독만 들였던 주제들을 공부하거나 연습해보는 것이 주요 목표지만, 의외로 괜찮은 결과물이 나올지도 모른다.

전체 일지 목록
------------

> <http://hatemogi.com/holiday-project/>

연습용 프로젝트는 아래 주소에,

> <https://github.com/hatemogi/holiday-project>

그날 그날 day-00 태그를 달아 올리고 있다.

데모사이트
---------

* http://holiday-project.hatemogi.com (stable)
* http://holiday-project-staging.hatemogi.com (staging)

직접설치
--------

```bash
git clone https://github.com/hatemogi/holiday-project.git
cd holiday-project
npm install
git submodule update --init
npm test
npm start
open http://0.0.0.0:3000/
```

개발해보기
---------

```bash
grunt
grunt watch
```

```watch``` 태스크 걸어놓고, 행복한 개발 시작~!
