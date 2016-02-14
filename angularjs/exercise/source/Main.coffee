

#CONTROLLERS#############################


class ArtistsListController
    constructor:($scope, $http)->
        $http.get('json/data.json').success((data)->
            $scope.artists = data;
            $scope.artistOrder = 'name';
        )


angular
.module('artistControllers',[])
.controller('ListController',['$scope', '$http', ArtistsListController]) # colocando os servicos dentro do array, consigo garantir que no minify nao fode




#APP#############################

class Router
    constructor:($routeProvider)->
        $routeProvider
        .when('/list', {
        	templateUrl:'partials/list.html'
        	controller:'ListController'
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
