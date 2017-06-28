// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require bootstrap
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function() {

  $("#ajax-action").click( function() {
    const AUTH_TOKEN = $("meta[name=csrf-token]").attr("content");
    request = $.ajax({
      type: "PATCH",
      dataType: "json",
      url: "/home/ajax_action",
      headers: {
        'X_CSRF_TOKEN': AUTH_TOKEN,
      },
      data: {
        some_data: {}
      },
    })
    .done((msg) => $(".response-div").html( msg.data ))
    .fail(() => console.log("Something went wrong."))
    // .always(() => console.log("complete"));
  });

});

// sms - ajax patch request.
