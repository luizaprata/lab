
class ApplicationController
    constructor:($scope, $http)->
        $http.get('json/data.json').success((data)->
            $scope.artists = data;
            $scope.artistOrder = 'name';
        )


angular
.module('myApp',[])
.controller('MyController',['$scope', '$http', ApplicationController]) # colocando os servicos dentro do array, consigo garantir que no minify nao fode