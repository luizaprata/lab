var ArtistsListController, Router;

ArtistsListController = (function() {
  function ArtistsListController($scope, $http) {
    $http.get('json/data.json').success(function(data) {
      $scope.artists = data;
      return $scope.artistOrder = 'name';
    });
  }

  return ArtistsListController;

})();

angular.module('artistControllers', []).controller('ListController', ['$scope', '$http', ArtistsListController]);

Router = (function() {
  function Router($routeProvider) {
    $routeProvider.when('/list', {
      templateUrl: 'partials/list.html',
      controller: 'ListController'
    }).otherwise({
      redirectTo: '/list'
    });
  }

  return Router;

})();

angular.module('myApp', ['ngRoute', 'artistControllers']).config(['$routeProvider', Router]);
