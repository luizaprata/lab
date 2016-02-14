class Main
    constructor:()->
        $.ajax
            url: 'cb.json'
            dataType: 'jsonp'
            complete: (data) =>
                @configureMap(JSON.parse(data.responseText))
                return
    ###*
    * Inicia configuracao inical do componente de mapa
    ###

    configureMap:(lojas) =>
        mapElement = document.getElementById('map')
        mapPanelElement = document.getElementById('panel')
        mapOptions = 
            center: new google.maps.LatLng(-14.2667716, -62.2782831)
            zoom: 4
            mapTypeId: google.maps.MapTypeId.ROADMAP
            zoomControlOptions: position: google.maps.ControlPosition.TOP_RIGHT
            panControlOptions: position: google.maps.ControlPosition.TOP_RIGHT
        @map = new google.maps.Map(mapElement, mapOptions)
        @plotMap(lojas)
        @plotList()
        input = document.getElementById('pac-input')
        @placeMarkers = []
        completeOptions =
            types: ['geocode']
            componentRestrictions: {country: 'br'}
        autocomplete = new google.maps.places.Autocomplete(input,completeOptions)
        autocomplete.bindTo('bounds', @map)
        @searchBox = new google.maps.places.SearchBox(input)
        @searchBox.addListener('places_changed', @onSearchBox)
        return
        
    onSearchBox:()=>
        places = @searchBox.getPlaces()
        return if places.length == 0
        
        @placeMarkers.forEach (marker) ->
            marker.setMap(null)
            return
        @placeMarkers = []
        
        bounds = new google.maps.LatLngBounds()
        places.forEach (place) =>
            icon = 
                url: place.icon
                size: new google.maps.Size(71, 71)
                origin: new google.maps.Point(0, 0)
                anchor: new google.maps.Point(17, 34)
                scaledSize: new google.maps.Size(25, 25)
        
        
            @placeMarkers.push(new google.maps.Marker(
                map: @map
                icon: icon
                title: place.name
                position: place.geometry.location
            ))
        
            if (place.geometry.viewport)
                bounds.union(place.geometry.viewport)
            else
                bounds.extend(place.geometry.location)
        
        @map.fitBounds(bounds)
        center = @map.getCenter()
        @findClosest(center.lat(), center.lng())
        
        return
        
    plotMap:(lojas)=>
        @stores = []
        @markers = []
        infowindow = new google.maps.InfoWindow()
        i = lojas.length
        while i-- > 0
            row = lojas[i]
            complemento = if row.complemento then row.complemento.trim() else ', '
            store = 
                id: i
                position: {lat:Number(row.latitude), lng:Number(row.longitude)}
                title: i + ":" + row.title
                address:  row.endereco + ', ' + row.numero + complemento + ' - ' + row.bairro + '<br/>' + row.cidade + '-' + row.uf
                hours: "Aberto: #{row.horario_de_funcionamento_semana}<br>Sábados: #{row.horario_de_funcionamento_sabado}<br>Domingos: #{row.horario_de_funcionamento_sabado}" 
                
                
            marker = new google.maps.Marker(
                position: new google.maps.LatLng(store.position.lat, store.position.lng)
                title: row.title
                icon: 'pin.png'
                id:i
            )
            content = "<div id=\"content\"><h4>#{store.title}</h4><p>#{store.address}</p><p>#{store.hours}</p></div>"
            google.maps.event.addListener marker, 'click', do (marker, content, infowindow, @findClosest,@map) ->
                ->
                    infowindow.close()
                    infowindow.setContent(content)
                    infowindow.open(map, marker)
                    pos = marker.position
                    findClosest(pos.lat(), pos.lng())
                    
                    return
            @markers.push(marker)
            @stores.push(store)
            
        markerCluster = new MarkerClusterer(@map, @markers) #lib agrupamento lojas
    
    plotList:()=>
        lista = $('#lista .items')
        i = @stores.length
        while i-- > 0
            store = @stores[i]
            item = $("<div class=\"item\" value=\"#{store.id}\"><h4>#{store.title}</h4><p>#{store.address}</p><p>#{store.hours}</p></div>")
            store.item = item
            lista.append(item)
        lista.find('.item').on('click', @onListItemClick)
        @orderList()
        
    onListItemClick:(event)=>
        event.preventDefault()
        event.stopPropagation()
        target = event.currentTarget
        idx = parseInt($(target).attr('value'))
        for marker in @markers
            if marker.id == idx
                break
        
        map.setCenter(marker.getPosition())
        map.setZoom(17)
        google.maps.event.trigger(marker, 'click')
        
    
    
    findClosest:(lat, lng) =>
        i = @stores.length
        while i-- > 0
            pos = @stores[i].position
            dLat  = pos.lat- lat
            dLng = pos.lng-lng
            d = (dLat*dLat) + (dLng*dLng)
            @stores[i].distance = d
        
        @stores.sort((a, b)->
            return a.distance-b.distance
        )
        @orderList()
    
    rad:(x)->
        return x*(Math.PI/180)
        
    orderList:()->
        lista = $('#lista .items')
        i = @stores.length
        while i-- > 0
           @stores[i].item.css({
                top:i*150
           })
        
onLoad = ()->
   main = new Main() 
    
initMap = ()->
    google.maps.event.addDomListener window, 'load', onLoad

#$(window).ready(init)



