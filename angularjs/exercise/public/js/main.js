var ArtistsListController, DetailsPageController, Router;

ArtistsListController = (function() {
  function ArtistsListController($scope, $http) {
    $http.get('json/data.json').success(function(data) {
      $scope.artists = data;
      return $scope.artistOrder = 'name';
    });
  }

  return ArtistsListController;

})();

DetailsPageController = (function() {
  function DetailsPageController($scope, $http, $routeParams) {
    $http.get('json/data.json').success(function(data) {
      var num, total;
      $scope.artists = data;
      $scope.idx = $routeParams.itemId;
      num = Number($routeParams.itemId);
      total = $scope.artists.length;
      $scope.prevItem = total - 1;
      if (num > 0) {
        $scope.prevItem = num - 1;
      }
      $scope.nextItem = 0;
      if (num < total - 1) {
        $scope.nextItem = num + 1;
      }
      return false;
    });
  }

  return DetailsPageController;

})();

angular.module('artistControllers', []).controller('ListController', ['$scope', '$http', ArtistsListController]).controller('DetailsController', ['$scope', '$http', '$routeParams', DetailsPageController]);

Router = (function() {
  function Router($routeProvider) {
    $routeProvider.when('/list', {
      templateUrl: 'partials/list.html',
      controller: 'ListController'
    }).when('/details/:itemId', {
      templateUrl: 'partials/details.html',
      controller: 'DetailsController'
    }).otherwise({
      redirectTo: '/list'
    });
  }

  return Router;

})();

angular.module('myApp', ['ngRoute', 'artistControllers']).config(['$routeProvider', Router]);
