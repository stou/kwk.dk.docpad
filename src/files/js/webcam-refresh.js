
$(document).ready(function() {
	// Active camera will refresh every 2 seconds
	var TIMEOUT = 2000;
	var refreshInterval = setInterval(function() {
		var random = Math.floor(Math.random() * Math.pow(2, 31));
		$('img#camera').attr('src', 'http://kwkcam.herokuapp.com/camera?i=' + Math.random());
	}, TIMEOUT);
});
