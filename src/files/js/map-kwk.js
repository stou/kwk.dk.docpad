
function initialize() {
  var myLatlng = new google.maps.LatLng(55.486755,9.526214);
  var mapOptions = {
    zoom: 12,
    center: myLatlng
  }
  var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);

  var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: 'Kolding Windsurfing Klub'
  });

  // google.maps.event.trigger(map, 'resize');
}

function loadScript() {
  var script = document.createElement('script');
  script.type = 'text/javascript';
  script.src = 'http://maps.googleapis.com/maps/api/js?sensor=false&callback=initialize';
  document.body.appendChild(script);
}

window.onload = loadScript;
