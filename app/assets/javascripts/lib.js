
function synchroniser(){
  $(".synchronise-action").click(function() {
    var clicked_button = $(this);
    clicked_button.attr("disabled", true);
    var AUTH_TOKEN = $("meta[name=csrf-token]").attr("content");
    request = $.ajax({
      type: "PATCH",
      dataType: "json",
      url: "/synchronisation/synchronise_action",
      headers: { 'X-CSRF-TOKEN': AUTH_TOKEN, },
      data: {
        synchronisation: {
          operation_code: $(this).attr("operation_code"),
          week_date: $('#week_date option:selected').val()
        }
      }
    })
    .done(function(msg) {
      alertify[msg.type](msg.message, 0);
      alertify.warning(msg.time_elapsed, 0);
    })
    .fail(function(){ alertify.error("Something went wrong. Contact the local administrator.", 0) })
    .always(function(){ clicked_button.attr("disabled", false); });
  });
}

function preseller_selector(){
  $("#preseller_id").change( function() {
    var AUTH_TOKEN = $("meta[name=csrf-token]").attr("content");
    request = $.ajax({
      type: "PATCH",
      dataType: "json",
      url: "/analytics/select_preseller_action",
      headers: { 'X-CSRF-TOKEN': AUTH_TOKEN, },
      data: {
        analytics: {
          preseller_id: $(this).val()
        }
      }
    })
    .done( function(msg) {
      // $(".test-div").html(msg.contractors); # debugging
      $("#contractor-selector").empty().append(msg.contractors);
    })
    .fail( function(){ alertify.error("Something went wrong. Contact the local administrator.") })
    // .always( function(){ $(this).addClass("disabled"); });
  });
}

function contractor_selector(){
  $("#contractor-selector").select2({ theme: "bootstrap" }).change(function() {
    var AUTH_TOKEN = $("meta[name=csrf-token]").attr("content");
    request = $.ajax({
      type: "PATCH",
      dataType: "json",
      url: "/analytics/select_contractor_action",
      headers: { 'X-CSRF-TOKEN': AUTH_TOKEN, },
      data: {
        analytics: {
          contractor_id: $(this).val(),
          year: $("#date_year").val()
        }
      }
    })
    .done(function(msg) {
      $(".contract-name").html(msg.contract_name);
      $(".contract-type").html(msg.contract_type);
      $(".contract-currency").html(msg.contract_currency);
      $(".contract-preseller").html(msg.contract_preseller);
      $(".contract-subdivision").html(msg.contract_subdivision);

      $(".contractor-name").html(msg.contractor_name);
      $(".contractor-code").html(msg.contractor_code);
      $(".contractor-state-id").html(msg.contractor_state_id);
      $(".contractor-physical-address").html(msg.contractor_physical_address);
      $(".contractor-legal-address").html(msg.contractor_legal_address);
      $(".contractor-type").html(msg.contractor_type);

      $(".analytics-body-wrapper").html(msg.client_debt_data);
      alertify[msg.type](msg.message);
      alertify.warning(msg.time_elapsed);
    })
    .fail(function(){ alertify.error("Something went wrong. Contact the local administrator.") })
    // .always(() => console.log("complete"));
  });
}

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
        delay: 10,
        // default position
        position: 'top-right',
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
