var ApplicationController;

ApplicationController = (function() {
  function ApplicationController($scope) {
    $scope.artists = [
      {
        "name": "Barot Bellingham",
        "shortname": "Barot_Bellingham",
        "reknown": "Royal Academy of Painting and Sculpture",
        "bio": "Barot has just finished his final year at The Royal Academy of Painting and Sculpture, where he excelled in glass etching paintings and portraiture. Hailed as one of the most diverse artists of his generation, Barot is equally as skilled with watercolors as he is with oils, and is just as well-balanced in different subject areas. Barot's collection entitled \"The Un-Collection\" will adorn the walls of Gilbert Hall, depicting his range of skills and sensibilities - all of them, uniquely Barot, yet undeniably different"
      }, {
        "name": "Jonathan G. Ferrar II",
        "shortname": "Jonathan_Ferrar",
        "reknown": "Artist to Watch in 2012",
        "bio": "The Artist to Watch in 2012 by the London Review, Johnathan has already sold one of the highest priced-commissions paid to an art student, ever on record. The piece, entitled Gratitude Resort, a work in oil and mixed media, was sold for $750,000 and Jonathan donated all the proceeds to Art for Peace, an organization that provides college art scholarships for creative children in developing nations"
      }
    ];
  }

  return ApplicationController;

})();

angular.module('myApp', []).controller('MyController', ApplicationController);
