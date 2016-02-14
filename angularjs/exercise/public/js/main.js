var Main, initMap, onLoad,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Main = (function() {
  function Main() {
    this.findClosest = bind(this.findClosest, this);
    this.onListItemClick = bind(this.onListItemClick, this);
    this.plotList = bind(this.plotList, this);
    this.plotMap = bind(this.plotMap, this);
    this.onSearchBox = bind(this.onSearchBox, this);
    this.configureMap = bind(this.configureMap, this);
    $.ajax({
      url: 'cb.json',
      dataType: 'jsonp',
      complete: (function(_this) {
        return function(data) {
          _this.configureMap(JSON.parse(data.responseText));
        };
      })(this)
    });
  }


  /**
  * Inicia configuracao inical do componente de mapa
   */

  Main.prototype.configureMap = function(lojas) {
    var autocomplete, completeOptions, input, mapElement, mapOptions, mapPanelElement;
    mapElement = document.getElementById('map');
    mapPanelElement = document.getElementById('panel');
    mapOptions = {
      center: new google.maps.LatLng(-14.2667716, -62.2782831),
      zoom: 4,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      zoomControlOptions: {
        position: google.maps.ControlPosition.TOP_RIGHT
      },
      panControlOptions: {
        position: google.maps.ControlPosition.TOP_RIGHT
      }
    };
    this.map = new google.maps.Map(mapElement, mapOptions);
    this.plotMap(lojas);
    this.plotList();
    input = document.getElementById('pac-input');
    this.placeMarkers = [];
    completeOptions = {
      types: ['geocode'],
      componentRestrictions: {
        country: 'br'
      }
    };
    autocomplete = new google.maps.places.Autocomplete(input, completeOptions);
    autocomplete.bindTo('bounds', this.map);
    this.searchBox = new google.maps.places.SearchBox(input);
    this.searchBox.addListener('places_changed', this.onSearchBox);
  };

  Main.prototype.onSearchBox = function() {
    var bounds, center, places;
    places = this.searchBox.getPlaces();
    if (places.length === 0) {
      return;
    }
    this.placeMarkers.forEach(function(marker) {
      marker.setMap(null);
    });
    this.placeMarkers = [];
    bounds = new google.maps.LatLngBounds();
    places.forEach((function(_this) {
      return function(place) {
        var icon;
        icon = {
          url: place.icon,
          size: new google.maps.Size(71, 71),
          origin: new google.maps.Point(0, 0),
          anchor: new google.maps.Point(17, 34),
          scaledSize: new google.maps.Size(25, 25)
        };
        _this.placeMarkers.push(new google.maps.Marker({
          map: _this.map,
          icon: icon,
          title: place.name,
          position: place.geometry.location
        }));
        if (place.geometry.viewport) {
          return bounds.union(place.geometry.viewport);
        } else {
          return bounds.extend(place.geometry.location);
        }
      };
    })(this));
    this.map.fitBounds(bounds);
    center = this.map.getCenter();
    this.findClosest(center.lat(), center.lng());
  };

  Main.prototype.plotMap = function(lojas) {
    var complemento, content, i, infowindow, marker, markerCluster, row, store;
    this.stores = [];
    this.markers = [];
    infowindow = new google.maps.InfoWindow();
    i = lojas.length;
    while (i-- > 0) {
      row = lojas[i];
      complemento = row.complemento ? row.complemento.trim() : ', ';
      store = {
        id: i,
        position: {
          lat: Number(row.latitude),
          lng: Number(row.longitude)
        },
        title: i + ":" + row.title,
        address: row.endereco + ', ' + row.numero + complemento + ' - ' + row.bairro + '<br/>' + row.cidade + '-' + row.uf,
        hours: "Aberto: " + row.horario_de_funcionamento_semana + "<br>Sábados: " + row.horario_de_funcionamento_sabado + "<br>Domingos: " + row.horario_de_funcionamento_sabado
      };
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(store.position.lat, store.position.lng),
        title: row.title,
        icon: 'pin.png',
        id: i
      });
      content = "<div id=\"content\"><h4>" + store.title + "</h4><p>" + store.address + "</p><p>" + store.hours + "</p></div>";
      google.maps.event.addListener(marker, 'click', (function(marker, content, infowindow, findClosest1, map1) {
        this.findClosest = findClosest1;
        this.map = map1;
        return function() {
          var pos;
          infowindow.close();
          infowindow.setContent(content);
          infowindow.open(map, marker);
          pos = marker.position;
          findClosest(pos.lat(), pos.lng());
        };
      })(marker, content, infowindow, this.findClosest, this.map));
      this.markers.push(marker);
      this.stores.push(store);
    }
    return markerCluster = new MarkerClusterer(this.map, this.markers);
  };

  Main.prototype.plotList = function() {
    var i, item, lista, store;
    lista = $('#lista .items');
    i = this.stores.length;
    while (i-- > 0) {
      store = this.stores[i];
      item = $("<div class=\"item\" value=\"" + store.id + "\"><h4>" + store.title + "</h4><p>" + store.address + "</p><p>" + store.hours + "</p></div>");
      store.item = item;
      lista.append(item);
    }
    lista.find('.item').on('click', this.onListItemClick);
    return this.orderList();
  };

  Main.prototype.onListItemClick = function(event) {
    var idx, j, len, marker, ref, target;
    event.preventDefault();
    event.stopPropagation();
    target = event.currentTarget;
    idx = parseInt($(target).attr('value'));
    ref = this.markers;
    for (j = 0, len = ref.length; j < len; j++) {
      marker = ref[j];
      if (marker.id === idx) {
        break;
      }
    }
    map.setCenter(marker.getPosition());
    map.setZoom(17);
    return google.maps.event.trigger(marker, 'click');
  };

  Main.prototype.findClosest = function(lat, lng) {
    var d, dLat, dLng, i, pos;
    i = this.stores.length;
    while (i-- > 0) {
      pos = this.stores[i].position;
      dLat = pos.lat - lat;
      dLng = pos.lng - lng;
      d = (dLat * dLat) + (dLng * dLng);
      this.stores[i].distance = d;
    }
    this.stores.sort(function(a, b) {
      return a.distance - b.distance;
    });
    return this.orderList();
  };

  Main.prototype.rad = function(x) {
    return x * (Math.PI / 180);
  };

  Main.prototype.orderList = function() {
    var i, lista, results;
    lista = $('#lista .items');
    i = this.stores.length;
    results = [];
    while (i-- > 0) {
      results.push(this.stores[i].item.css({
        top: i * 150
      }));
    }
    return results;
  };

  return Main;

})();

onLoad = function() {
  var main;
  return main = new Main();
};

initMap = function() {
  return google.maps.event.addDomListener(window, 'load', onLoad);
};
