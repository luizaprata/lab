
class ApplicationController
    constructor:($scope, $http)->
        $http.get('json/data.json').success((data)->
            $scope.artists = data;
        )



angular
.module('myApp',[])
.controller 'MyController', ApplicationController