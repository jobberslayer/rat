$(function(){ 
  $(".schedule_type_select").change(function() { 
    var key = "#" + $(this).attr('id') + " option:selected";
    var kind = $(key).val();
    var se = $(this).closest('div');
    se.find('div.container').hide();
    se.find('#schedule_' + kind).show();
  });
});
