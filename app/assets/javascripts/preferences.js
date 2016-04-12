$(document).ready(function(){
  $('#timepicker1').timepicker();
  $('#timepicker2').timepicker();
  $('.input-group.date').datepicker({
    todayBtn: "linked",
    endDate: "+1y"
    });
});