

#CONTROLLERS#############################


class ArtistsListController
    constructor:($scope, $http)->
        $http.get('json/data.json').success((data)->
            $scope.artists = data;
            $scope.artistOrder = 'name';
        )

class DetailsPageController
    constructor:($scope, $http, $routeParams)->
        $http.get('json/data.json').success((data)->
            $scope.artists = data;
            $scope.idx = $routeParams.itemId;

            num = Number($routeParams.itemId)
            total = $scope.artists.length

            $scope.prevItem = total-1
            if num > 0
                $scope.prevItem = num-1

            $scope.nextItem = 0
            if num < total-1
                $scope.nextItem = num+1
            false
        )



angular
.module('artistControllers',['ngAnimate'])
.controller('ListController',['$scope', '$http', ArtistsListController]) # colocando os servicos dentro do array, consigo garantir que no minify nao fode
.controller('DetailsController',['$scope', '$http', '$routeParams', DetailsPageController]) # colocando os servicos dentro do array, consigo garantir que no minify nao fode




#APP#############################

class Router
    constructor:($routeProvider)->
        $routeProvider
        .when('/list', {
            templateUrl:'partials/list.html'
            controller:'ListController'
        })
        .when('/details/:itemId', {
            templateUrl:'partials/details.html'
            controller:'DetailsController'
        })
        .otherwise({
            redirectTo:'/list'
        })

angular
.module('myApp',[
    'ngRoute'
    'artistControllers'
])
.config(['$routeProvider', Router])
