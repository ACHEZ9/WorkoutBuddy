$(document).ready(function(){
  $('#timepicker1').timepicker();
  $('.input-group.date').datepicker({
    todayBtn: "linked",
    endDate: "+1y"
    });
  $('#sport_select').on('change', submitForm);
  $('#distance_select').on('change', submitForm);
});


var submitForm = function() {
  $('#events_search').submit()
}