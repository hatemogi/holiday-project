angular.module("holiday", ['ngRoute'])
  .controller "LoginCtrl", () ->
    this.welcome = "환영합니다"
    this
  .controller "D3Ctrl", ['$scope', '$http', ($scope, $http) ->
    this.tab = "sankey"
    $scope.content = ''
    this.selectTab = (t) ->
      this.tab = t
      console.log ["sankey 클릭됨", t]
      if t == 'sankey'
        this.drawSankey()
    this.isSelected = (t) ->
      this.tab == t
    this.drawSankey = () ->
      d3.json "/assets/commits.json", (json) ->
        nodes = [{index: 0}, {index: 1}, {index: 2}, {index: 3}]
        links = [
          {source: 0, target: 2, value: 5}, 
          {source: 1, target: 2, value: 10}, 
          {source: 1, target: 2, value: 10}, 
          {source: 0, target: 3, value: 15}]
        sankey = d3.sankey()
          .size([600, 400])
          .nodeWidth(10)
          .nodePadding(10)
          .nodes(nodes)
          .links(links)
          .layout(32)
        g = d3.select("svg.d3").attr("width", 600).attr("height", 400).append("g")
        g.selectAll('.link').data(links).enter().append("path")
          .attr("d", sankey.link())
          .attr("class", "link")
          .attr("stroke-width", (d) -> d.dy)
        node = d3.select("svg.d3").append("g").selectAll(".node").data(nodes)
          .enter().append("g")
          .attr("class", "node")
          .attr("transform", ((d) -> "translate(#{d.x}, #{d.y})"))
        node.append("rect")
          .attr("height", (d) -> d.dy)
          .attr("width", sankey.nodeWidth())

    this
  ]
