jQuery.fn.loadScheduleTypeForm = function() {
  this.find(".schedule_type_select").change(function() { 
    var key = "#" + $(this).attr('id') + " option:selected";
    var kind = $(key).val();
    var se = $(this).closest('div');
    se.find('div.container').hide();
    se.find('#schedule_' + kind).show();
  });
}

jQuery.fn.defaultDatePicker = function  () {
  this.datepicker({ 
    dateFormat: "yy-mm-dd",
    changeMonth: true, 
    changeYear: true, 
  });
  this.attr('readonly', true);
}

jQuery.fn.refreshSchedulerEvents = function() {
  this.loadScheduleTypeForm();
  this.find('.scheduler_once_date').defaultDatePicker();
  this.find('.scheduler_yearly_date').defaultDatePicker();
  this.find('.scheduler_weekly_date').defaultDatePicker();
  this.find('.scheduler_few_months_date').defaultDatePicker();
}

$(function() { 
  $(".task-scheduler-div").refreshSchedulerEvents();
});


