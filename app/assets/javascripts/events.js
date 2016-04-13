$(document).ready(function(){
  $('#timepicker1').timepicker();
  $('.input-group.date').datepicker();
  $('#sport_select').on('change', submitForm);
  $('#distance_select').on('keyup', submitForm);
});


var submitForm = function() {
  $('#events_search').submit()
}