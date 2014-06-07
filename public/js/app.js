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
  ]).controller("EditorCtrl", [
    '$scope', '$http', function($scope, $http) {
      var editor;
      window.editor = editor = ace.edit("editor");
      editor.setTheme("ace/theme/tomorrow");
      editor.getSession().setMode("ace/mode/dot");
      editor.focus();
      this.engines = ['dot', 'neato', 'fdp', 'sfdp', 'twopi', 'circo'];
      this.run = function(e) {
        return $http.post("/dot", {
          text: editor.getValue(),
          engine: $('#engine-select').val()
        }).success(function(data, status) {
          $('#output').html(data);
          return console.log(['success', data]);
        }).error(function(res) {
          return console.log(['error', res]);
        });
      };
      return this;
    }
  ]);

}).call(this);

//# sourceMappingURL=app.js.map
