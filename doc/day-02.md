---
title: '30일 프로젝트 - 둘째날'
kind: article
created_at: 2014-05-08
layout: article
---

나는 30일간의 안식휴가 중이다. 휴가 동안 개인 개발 프로젝트를 진행하고 있고, 오늘은 그 둘째 날이다. 

[첫날]은, 클라이언트 측에서의 자바스크립트 테스팅환경을 엉성하게나마 만들었다. 출발이 좋다. 좋다. 그럼 서버사이드에서의 테스팅은 어쩐다? [Node.js]로 돌아가는 [express]로 웹사이트를 구축하려 마음먹은 상태이니, Node.js용 테스팅 프레임워크를 찾아봤다. 

> [mocha], [vows], [expresso], [should.js], [nodeunit], [jasmine]

대충 찾아봐도 우후죽순 쏟아진다. 루비용 테스팅 프레임워크를 고를 때도, 기본 RSpec을 쓸지 MiniTest를 쓸지 Shoulda를 쓸지 고민해보았지만, 결론은, 

> 많이 쓰이는 프레임워크는 다 좋다. 

워낙 다들 수준이 높아서, 약간의 개인적 호불호가 나뉠 뿐, 우열을 가르는 것이 큰 의미 없어 보인다. 굳이 내게 테스팅 프레임워크 중요한 기준을 꼽으라면, 

* 단순할 것 
* 문서가 잘 정리돼 있을 것
* 최근까지 업데이트가 진행되고 있을 것
* 내가 쓰고자 하는 프레임워크들과 잘 연동될 것

이 정도로 고민한다. 이런 프레임워크 선택할 때, 언젠가부터 중요하게 자리 잡은 생각도 있다.

> 다 우수한 프레임워크 중에서 최고를 고르려고 지나치게 고민하지 말고, 잘 쓸 수 있는 것 하나를 빠르게 정하자.

한번 정해서 쓰면, 나중에 바꾸기가 번거로우므로 처음에 잘 선택해야 한다는 압박을 받기 쉬운데, 그렇다고, 지나치게 고민한다고 해서, 오랜 나중까지 올바른 선택이었다고 판단할 수 있는 것은 아니다. 오히려, 그 고민하는 시간을 짧게 줄이고, 나중에 문제 생겼을 때, 해결하는데 그 시간을 사용한다고 생각하는 것이 나을지 모른다. 고민을 오래 했다면, 아마도, 바꿔야 할 순간이 왔을 때도, '충분히 오래 고민해서 결정한 일이야. 잘못된 선택일 리 없어'라고 합리화하며 불편한 고집을 부리게 될 수도 있다. 한편, 오랜 고민의 좋은 점이 있다면, 나름대로 노력을 들였으므로, 다른 대안이 눈에 띄었을 때 너무 쉽게 흔들리지는 않는다는 장점도 있다. 

선택의 폭이 다양하면, 그중에 최고의 선택을 고르고 싶은 게 당연한 심리겠지만, 나 혼자 하는 프로젝트의 프레임워크 고르는 일이, 차를 사는 일이나, 직장을 고르는 일이나, 이사 갈 집을 고르는 것처럼 중요한 일은 아니지 않은가? 비슷한 선택안 사이에서 갈팡질팡 고민하는 것만큼 주의력을 갉아먹는 일이 또 있을까?

하지만, 아쉽게도 지나친 고민인지 아닌지는, 그 '지나친 고민'을 해보고 나서야 알 수 있다는 게 함정이겠다.

### Jasmine을 Node.js 테스트에 사용

일단 큰 고민은 잠시 중단하기로 하고, [어제] 살짝 살펴본 Jasmine을 서버사이드에서 쓰면 어떻게 되는지 해보기로 한다. 

약간의 웹검색+실습 노동을 해보니, 

```
npm install -g jasmine-node
```
위의 npm명령어로 설치할 수 있는 ```jasmine-node```라는 모듈이 있어서, 노드 환경에서 쉽게 jasmine 테스트를 실행할 수 있다. 

```javascript
var jasmine_trial = require('../lib/jasmine_trial');

describe("자스민 써보기", function() {
  it("contains text property", function() {
    expect(jasmine_trial.text()).toBe("자스민 안녕!");
  });
});
```

<img src="/img/holiday-project/jasmine-node-running.png" class="img-rounded" style="width:500px;"/>

위의 코드가 테스트케이스(스펙)고, 아래가 터미널에서 [jasmine-node]를 실행한 화면이다. ```--verbose``` 옵션으로, 스펙의 설명을 보겠다는 뜻이고, ```--autotest```는 한번 실행하고 끝내는 것이 아니라, 계속 관련 파일들을 주시하고 있겠다는 의미다. [어제]의 karma처럼 파일을 주시하고 있다가, 변경되면 다시 테스트를 돌린다. 

이 정도로 웹 브라우저와 node.js에서 테스트케이스를 수행할 수 있으면, 그럭저럭 괜찮아 보인다. 

여기서 마무리하려니, 진도가 조금 느린 감이 있는데, 프로젝트를 진행 중이기도 하지만, 분명한 것은 **나는 휴가 중**이니까. 게다가 오늘 석양은 매우 멋질듯해서, 이제 맥북은 접고 노을을 감상하러 간다.

![](/img/holiday-project/sunset-day-02.jpg)

오늘은 여기까지. 

[첫날]: /holiday-project-day-01/
[어제]: /holiday-project-day-01/
[Node.js]: http://nodejs.org/
[Karma]: http://karma-runner.github.io/
[Jasmine]: http://jasmine.github.io/
[express]: http://expressjs.com/
[mocha]: http://visionmedia.github.io/mocha/
[vows]: http://vowsjs.org/
[expresso]: http://visionmedia.github.io/expresso/
[should.js]: https://github.com/visionmedia/should.js
[nodeunit]: https://github.com/caolan/nodeunit
[jasmine-node]: https://github.com/mhevery/jasmine-node