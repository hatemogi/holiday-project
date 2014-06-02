(function() {
  angular.module("holiday", ['ngRoute']).controller("LoginCtrl", function() {
    this.welcome = "환영합니다";
    return this;
  }).controller("D3Ctrl", [
    '$scope', '$http', function($scope, $http) {
      this.tab = "sankey";
      $scope.content = '';
      this.selectTab = function(t) {
        this.tab = t;
        console.log(["sankey 클릭됨", t]);
        if (t === 'sankey') {
          return this.drawSankey();
        }
      };
      this.isSelected = function(t) {
        return this.tab === t;
      };
      this.drawSankey = function() {
        return d3.json("/assets/commits.json", function(json) {
          var g, links, node, nodes, sankey;
          nodes = [
            {
              index: 0
            }, {
              index: 1
            }, {
              index: 2
            }, {
              index: 3
            }
          ];
          links = [
            {
              source: 0,
              target: 2,
              value: 5
            }, {
              source: 1,
              target: 2,
              value: 10
            }, {
              source: 1,
              target: 2,
              value: 10
            }, {
              source: 0,
              target: 3,
              value: 15
            }
          ];
          sankey = d3.sankey().size([600, 400]).nodeWidth(10).nodePadding(10).nodes(nodes).links(links).layout(32);
          g = d3.select("svg.d3").attr("width", 600).attr("height", 400).append("g");
          g.selectAll('.link').data(links).enter().append("path").attr("d", sankey.link()).attr("class", "link").attr("stroke-width", function(d) {
            return d.dy;
          });
          node = d3.select("svg.d3").append("g").selectAll(".node").data(nodes).enter().append("g").attr("class", "node").attr("transform", (function(d) {
            return "translate(" + d.x + ", " + d.y + ")";
          }));
          return node.append("rect").attr("height", function(d) {
            return d.dy;
          }).attr("width", sankey.nodeWidth());
        });
      };
      return this;
    }
  ]);

}).call(this);

//# sourceMappingURL=app.js.map
