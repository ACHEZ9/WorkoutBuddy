$(document).ready(function(){
  $('#timepicker1').timepicker();
  $('.input-group.date').datepicker({
    todayBtn: "linked",
    endDate: "+1y"
    });
  $('#sport_select').on('change', submitForm);
  $('#distance_select').on('change', submitForm);
  $('#order_by_select').on('change', submitForm);
  $('#getLocation').on('click', getLocation);
  $('.thumbnail').hover(function(){}, function(){});
});


var submitForm = function() {
  $('#events_search').submit()
}


function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(onSuccess, showError,{timeout:5000});
    } else {
        document.getElementById("location_message").innerHTML = "Geolocation is not supported by this browser.";
    }
}

function onSuccess(position) {
  var lat = position.coords.latitude;
  var long = position.coords.longitude;
  document.getElementById("location_message").innerHTML = "Current Location";
  document.getElementById("cur_lat").value = lat;
  document.getElementById("cur_long").value = long;
}

function showError(error) {
    switch(error.code) {
        case error.PERMISSION_DENIED:
            document.getElementById("location_message").innerHTML = "Geolocation Blocked."
            break;
        case error.POSITION_UNAVAILABLE:
            document.getElementById("location_message").innerHTML = "Location unavailable."
            break;
        case error.TIMEOUT:
            document.getElementById("location_message").innerHTML = "Request Timed out."
            break;
        case error.UNKNOWN_ERROR:
            document.getElementById("location_message").innerHTML = "An unknown error occurred."
            break;
    }
}
