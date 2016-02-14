var ApplicationController;

ApplicationController = (function() {
  function ApplicationController($scope, $http) {
    $http.get('json/data.json').success(function(data) {
      $scope.artists = data;
      return $scope.artistOrder = 'name';
    });
  }

  return ApplicationController;

})();

angular.module('myApp', []).controller('MyController', ['$scope', '$http', ApplicationController]);
