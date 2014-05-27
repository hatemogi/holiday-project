(function() {
  angular.module("holiday", []).controller("LoginCtrl", function() {
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
          return $http.get('/d3/sankey').success(function(r) {
            return $scope.content = r;
          });
        }
      };
      this.isSelected = function(t) {
        return this.tab === t;
      };
      return this;
    }
  ]);

}).call(this);

//# sourceMappingURL=app.js.map