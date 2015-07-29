// wrap other $() operations on your page that depend on the DOM being ready
$(function() {

	renderHandlebars();
  var directionsDisplay;
  var directionsService = new google.maps.DirectionsService();
  var map;
  // geolocation variables
  var userLat;
  var userLong;
  var userLatLong;
  var transitLayer;
  var bikeLayer;
  var trafficLayer;
  var weather;
  var mapLat = 37.768120;
  var mapLong = -122.441875;

  function initialize() {
    // get the div element to put the map in
    var mapDiv = document.getElementById('map-canvas');

    directionsDisplay = new google.maps.DirectionsRenderer({
      suppressMarkers: true,
      suppressInfoWindows: true
    });

    // MapOptions fields which affect the visibility and presentation of controls
    var mapOptions = {
      zoom: 12,
      center: new google.maps.LatLng(mapLat, mapLong),
      mapTypeId: google.maps.MapTypeId.TERRAIN
    };

    // Map constructor creates a new map using any optional parameters that are passed in
    map = new google.maps.Map(mapDiv, mapOptions);
    directionsDisplay.setMap(map);

    transitLayer = new google.maps.TransitLayer();
    bikeLayer = new google.maps.BicyclingLayer();
    trafficLayer = new google.maps.TrafficLayer();

  } // closing tag for initialize function

  function checkForLoc() {
    if (Modernizr.geolocation) {
      navigator.geolocation.getCurrentPosition(getLoc, resErr);
    } else {
      alert('Your browser does not support geolocation');
      weather = 'https://api.wunderground.com/api/0fd9bd78fc2f4356/geolookup/conditions/q/' + mapLat + ',' + mapLong + '.json';
    }
  }

  function getLoc(location) {
    // variables declared globally at the top of the page
    userLat = location.coords.latitude;
    userLong = location.coords.longitude;
    userLatLong = new google.maps.LatLng(userLat, userLong);
    var marker = new google.maps.Marker({
      position: userLatLong,
      map: map,
      title: "You Are Here!",
      icon: 'usermarker.png'
    });
    weather = 'https://api.wunderground.com/api/0fd9bd78fc2f4356/geolookup/conditions/q/' + userLat + ',' + userLong + '.json';
    getWeather(weather);
  }

  function resErr(error) {
    if (error.code == 1) {
      alert('Your privacy is respected! Your location has not been detected.');
    } else if (error.code == 2) {
      alert('Location Unavailable');
    } else if (error.code == 3) {
      alert('TimeOut');
    }
    weather = 'https://api.wunderground.com/api/0fd9bd78fc2f4356/geolookup/conditions/q/' + mapLat + ',' + mapLong + '.json';
    getWeather(weather);
  }


  function getWeather(weather) {
    $.ajax({
      url: weather,
      jsonp: "callback",
      dataType: "jsonp"
    }).done(function(data) {
      //setting the spans to the correct parameters
      $('#location').html(data['location']['city']);
      $('#temp').html(data['current_observation']['temp_f']);
      $('#desc').html(data['current_observation']['weather']);
      $('#wind').html(data['current_observation']['wind_string']);
      //filling the image src attribute with the image url
      $('#img').attr('src', data['current_observation']['icon_url']);
    });
  }

  // when you click the search submit button, this runs
  $("input[type='submit']").click(function(e) {
    e.preventDefault();
    // calling the searchYelp function
    // and passing in the geolocation global variables
    searchYelp(userLat, userLong);
  })

  function searchYelp(lat, lng) {
    $.ajax({
      // url is looking for the results action (see routes.rb)
      url: '/results?lat=' + lat + '&long=' + lng,
      method: 'get',
      dataType: 'json'
    }).done(function(data) {
      console.log(data)
    })
  }


  function renderHandlebars() {
    // At its most basic, Handlebars is just a place to put your client-side HTML
    // Handlebars makes sure it's clean and safe
    // need the path to the hbs file here
    var html = HandlebarsTemplates['users/index'](); // data goes in parens when you're sending data to hbs file
    // John and Tim pointed out, we're using an ID because only one ID (so don't get an array)
    $('#map').append(html);
  }

  initialize();
  checkForLoc();

  //display public transit network using the TransitLayer object
  function showTransit() {
    bikeLayer.setMap(null);
    trafficLayer.setMap(null);
    if (typeof transitLayer.getMap() == 'undefined' || transitLayer.getMap() === null) {
      transitLayer.setMap(map);
    } else {
      transitLayer.setMap(null);
    };
  }

  function showBike() {
    transitLayer.setMap(null);
    trafficLayer.setMap(null);
    if (typeof bikeLayer.getMap() == 'undefined' || bikeLayer.getMap() === null) {
      bikeLayer.setMap(map);
    } else {
      bikeLayer.setMap(null);
    };
  }

  function showTraffic() {
    bikeLayer.setMap(null);
    transitLayer.setMap(null);
    if (typeof trafficLayer.getMap() == 'undefined' || trafficLayer.getMap() === null) {
      trafficLayer.setMap(map);
    } else {
      trafficLayer.setMap(null);
    };
  }

  $("#transit").click(function(event) {
    event.stopPropagation();
    showTransit();
  });

  $("#bike").click(function(event) {
    event.stopPropagation();
    showBike();
  });

  $("#traffic").click(function(event) {
    event.stopPropagation();
    showTraffic();
  });

}); // closing tag for everything in this file

