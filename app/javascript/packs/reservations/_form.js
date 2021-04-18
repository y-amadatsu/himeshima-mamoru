// TODO: なぜか application.jsがうまく動かない…
var dt = require('daterangepicker/daterangepicker');
var Inputmask = require('inputmask/dist/jquery.inputmask');

import "../reservations.scss"

$(function(){
  $('#reservation_reserved_at').daterangepicker({
    timePicker: true,
    timePicker24Hour: true,
    timePickerIncrement: 30,
    singleDatePicker: true,
    autoUpdateInput: false,
    showDropdowns: true,
    locale: {
      format: 'YYYY-MM-DD HH:mm'
    }
  }, function(chosen_date){
    $(this.element[0]).val(chosen_date.format('YYYY-MM-DD HH:mm'));
  });

  $('#reservation_birthday_on').daterangepicker({
    singleDatePicker: true,
    autoUpdateInput: false,
    showDropdowns: true,
    locale: {
      format: 'YYYY-MM-DD HH:mm'
    }
  }, function(chosen_date){
    $(this.element[0]).val(chosen_date.format('YYYY-MM-DD'));
  });

  //$('#reservation_phone_number').inputmask('dd/mm/yyyy', { 'placeholder': '___-____-____' })
});