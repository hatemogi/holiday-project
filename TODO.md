TODO
==========
* 엔진 사용시 옵션 지정
* 엔진간 파이프 연결 <http://www.graphviz.org/Gallery/undirected/gd_1994_2007.html>
* Crockford Base32 정리
* [Force Layout Multiples (Independent)](http://bl.ocks.org/mbostock/1804889)
* http://bl.ocks.org/rkirsling/5001347
* http://ghv.artzub.com/#repo=GitHubCodeSwarm&amp;climit=100&amp;user=artzub
* 도메인등록 (후보: gvdoodle.com + gvd.kr, graphdoodle.com, gvfiddle.com, gvbin.com, graphviz-online.com, gvo.kr, gvon.in)
FIX
===========

DONE
===========
* SVG 웹페이지에 그릴 때 크기 조절 (너무 큰 경우 축소, viewBox를 유지한채, width/height를 조정하면 됨.)
* [GTS](http://gts.sourceforge.net/) 추가해서 graphviz 빌드: ```brew install graphviz --with-gts```
* SVG 좌표 소수점 오류 표기되는 원인 찾기 (리눅스에서는 괜찮지 않나?) -> spawn결과 join의 문제였음. ```String#join()```은 기본 ,로 붙여짐. join('')로 호출해야 함.
* SVG 가져온 것 임베딩시 한글 깨짐
* Sankey diagram으로 표현해보기