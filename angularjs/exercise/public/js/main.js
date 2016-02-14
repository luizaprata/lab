var ApplicationController;

ApplicationController = (function() {
  function ApplicationController($scope, $http) {
    $http.get('json/data.json').success(function(data) {
      return $scope.artists = data;
    });
  }

  return ApplicationController;

})();

angular.module('myApp', []).controller('MyController', ['$scope', '$http', ApplicationController]);
