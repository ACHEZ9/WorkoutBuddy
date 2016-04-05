$(document).ready(function(){
  var pusher = new Pusher('3a8ce8531d31a1b267bd');
  var channel = pusher.subscribe('notifications_channel');
  var userId = document.getElementById('user_id').innerHTML;
  channel.bind('notification_event_' + userId, function(data) {
    if(data)
    var count = document.getElementById('notification_badge').innerHTML;
    if (count == "") {
      count = 1;
    } else {
      count = parseInt(count) + 1;
    }
    alert(count)
    document.getElementById('notification_badge').innerHTML = count;
  });
});