// wrap other $() operations on your page that depend on the DOM being ready
// $(".users.new").ready(function(){   
//   alert("HELLO")    
// })      
// another way to specify a page specific event, but this needs turbo-links to work, which is not the case for us.

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

 
// ----------------------------- INITIALIZE MAP -----------------------------

  function initialize() {
    // get the div element to put the map in
    var mapDiv = document.getElementById('map-canvas');

    directionsDisplay = new google.maps.DirectionsRenderer({
      suppressMarkers: true,
      suppressInfoWindows: true
    });

    // MapOptions: visibility and presentation of controls
    var mapOptions = {
      zoom: 12,
      center: new google.maps.LatLng(mapLat, mapLong),
      mapTypeId: google.maps.MapTypeId.TERRAIN
    };

    // Map constructor: create new map. Pass in optional parameters.
    map = new google.maps.Map(mapDiv, mapOptions);
    directionsDisplay.setMap(map);

    transitLayer = new google.maps.TransitLayer();
    bikeLayer = new google.maps.BicyclingLayer();
    trafficLayer = new google.maps.TrafficLayer();

  } // close initialize function

// ----------------------------- GEOLOCATION -----------------------------

  function checkForLoc() {
    if (Modernizr.geolocation) {
      navigator.geolocation.getCurrentPosition(getLoc, resErr);
    } else {
      alert('Your browser does not support geolocation');
      weather = 'https://api.wunderground.com/api/0fd9bd78fc2f4356/geolookup/conditions/q/' + mapLat + ',' + mapLong + '.json';
    }
  }

  function getLoc(location) {
    // variables declared globally, see top of script
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

// ----------------------------- WEATHER LAYER OBJECT -----------------------------
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

// ----------------------------- SEARCH YELP -----------------------------
  // click search & call searchYelp function with geolocation global variables
  // must select the search button only
  $("input[value='Search']").click(function(e) {
    e.preventDefault();
    searchYelp(userLat, userLong);
  })

  function searchYelp(lat, lng) {
    $.ajax({
      // url looks for 'results' action (see routes.rb)
      url: '/results?lat=' + lat + '&long=' + lng,
      method: 'get',
      dataType: 'json'
    }).done(function(data) {
      console.log(data)
    })
  }

// ----------------------------- HANDLEBARS -----------------------------

  // At its most basic, Handlebars is just a place to put your client-side HTML
  // Handlebars makes sure it's clean and safe
  // need the path to the hbs file here
  function renderHandlebars() {
    var html = HandlebarsTemplates['users/index'](); // place data in parens when you're sending data to hbs file
    // Use an ID to ensure only one, we don't an array
    $('#map').append(html);
  }

  initialize();
  checkForLoc();


// ----------------------------- TRANSIT LAYER OBJECT -----------------------------
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

// ----------------------------- JQUERY EVENT HANDLERS -----------------------------
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

