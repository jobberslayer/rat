// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require ckeditor/init
//= require foundation
//= require_tree .

// still not sure why I have to do this. 
// It has something to do with foundation and ckeditor not playing nice together
// After page is loaded replace all textareas with ckeditor
// $( document ).ready(function() {
//   $('textarea').each(function() { 
//     CKEDITOR.replace( 
//       $(this).attr('id'),
//       {
//         toolbar : 'Basic',
//       }
//     )
//   })
// })

function status_msg(msg) {
  $('#status-message').text(msg).animate({'margin-bottom':0},200);
    setTimeout( function(){
        $('#status-message').animate({'margin-bottom':-25},200);
    }, 5*1000);
}

function status_error_msg(msg) {
  $('#status-message-error').text(msg).animate({'margin-bottom':0},200);
    setTimeout( function(){
        $('#status-message-error').animate({'margin-bottom':-25},200);
    }, 10*1000);
}

function toggle(div_name, butt_name, on_text, off_text) {
  $("#" + div_name).toggle(); 
  if ( $("#" + div_name).is(':visible') ) {
    $("#" + butt_name).val(on_text);
  } else {
    $("#" + butt_name).val(off_text);
  }
}

function toggle_tree(div_name, arrow) {
  $(div_name).toggle(); 
  if ( $(div_name).is(':visible') ) {
    $(arrow).removeClass('ui-icon-triangle-1-e').addClass('ui-icon-triangle-1-s');
  } else {
    $(arrow).removeClass('ui-icon-triangle-1-s').addClass('ui-icon-triangle-1-e');
  }
}

function toggle_class_link(div_name, butt_name, on_text, off_text) {
  $("." + div_name).toggle(); 
  if ( $("." + div_name).is(':visible') ) {
    $("#" + butt_name).text(on_text);
  } else {
    $("#" + butt_name).text(off_text);
  }
}
