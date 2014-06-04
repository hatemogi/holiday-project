  angular.module("holiday", [])
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
          $http.get('/d3/sankey').success (r) ->
            $scope.content = r
      this.isSelected = (t) ->
        this.tab == t
      this
    ]
    .controller "EditorCtrl", ['$scope', '$http', ($scope, $http) ->
      editor = ace.edit("editor")
      # editor.setTheme("ace/theme/clouds")
      editor.setTheme("ace/theme/tomorrow")
      # editor.setTheme("ace/theme/crimson_editor")
      editor.getSession().setMode("ace/mode/dot")
      editor.getSession().setUseWrapMode true
      editor.focus()

      this.engines = ['dot', 'neato', 'fdp', 'sfdp', 'twopi', 'circo']
      this.run = (e) ->
        # $http.defaults.headers.post["Content-Type"] = "text/plain" 
        $http.post("/dot", {
          text: editor.getValue()
          engine: $('#engine-select').val()
        }).success(
          (data, status) -> 
            $('#output').html data
            console.log ['success', data]
        ).error (res) ->
          console.log ['error', res]
      this
    ]
