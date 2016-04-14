$(document).ready(function(){
  $('#timepicker1').timepicker();
  $('.input-group.date').datepicker();
});

$(document).ready(function () {

    (function ($) {

        $('#filter').keyup(function () {

            var rex = new RegExp($(this).val(), 'i');
            $('.searchable card').hide();
            $('.searchable card').filter(function () {
                return rex.test($(this).text());
            }).show();

        })

    }(jQuery));

});
