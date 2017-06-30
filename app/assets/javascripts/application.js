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
//= require alertifyjs/build/alertify
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function() {

  $(".synchronise-action").click( function() {
    const AUTH_TOKEN = $("meta[name=csrf-token]").attr("content");
    request = $.ajax({
      type: "PATCH",
      dataType: "json",
      url: "/synchronisation/synchronise_action",
      headers: {
        'X_CSRF_TOKEN': AUTH_TOKEN,
      },
      data: {
        synchronisation: {
          operation_code: $(this).attr("operation_code"),
          week_date: $('#week_date option:selected').val()
        }
      }
    })
    .done((msg) => {
      $(".response-div").html( msg.json_response );
      alertify[msg.type](msg.message)
      alertify.warning(msg.time_elapsed)
    })
    .fail(() => alertify.error("მოიცა რა."))
    // .always(() => console.log("complete"));
  });

  alertify_options();
});

// sms - ajax patch request.

function alertify_options(){
  alertify.defaults = {
    // dialogs defaults
    // autoReset:true,
    // basic:false,
    // closable:true,
    // closableByDimmer:true,
    // frameless:false,
    // maintainFocus:true, // <== global default not per instance, applies to all dialogs
    // maximizable:true,
    // modal:true,
    // movable:true,
    // moveBounded:false,
    // overflow:true,
    // padding: true,
    // pinnable:true,
    // pinned:true,
    // preventBodyShift:false, // <== global default not per instance, applies to all dialogs
    // resizable:true,
    // startMaximized:false,
    // transition:'pulse',

    // notifier defaults
    notifier:{
        // auto-dismiss wait time (in seconds)
        delay:6,
        // default position
        position:'top-right',
        // adds a close button to notifier messages
        closeButton: false
    },

    // language resources
    // glossary:{
    //     // dialogs default title
    //     title:'AlertifyJS',
    //     // ok button text
    //     ok: 'OK',
    //     // cancel button text
    //     cancel: 'Cancel'
    // },

    // theme settings
    // theme:{
    //     // class name attached to prompt dialog input textbox.
    //     input:'ajs-input',
    //     // class name attached to ok button
    //     ok:'ajs-ok',
    //     // class name attached to cancel button
    //     cancel:'ajs-cancel'
    // }
  };
}
