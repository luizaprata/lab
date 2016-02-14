var ApplicationController;

ApplicationController = (function() {
  function ApplicationController($scope) {
    $scope.author = {
      name: 'Luiza Prata',
      title: 'dev',
      company: 'euler'
    };
  }

  return ApplicationController;

})();

angular.module('myApp', []).controller('MyController', ApplicationController);
