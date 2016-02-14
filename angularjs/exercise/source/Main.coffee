
class ApplicationController
    constructor:($scope)->
        $scope.author = {
            name: 'Luiza Prata'
            title: 'dev'
            company: 'euler'
        }



angular
.module('myApp',[])
.controller 'MyController', ApplicationController