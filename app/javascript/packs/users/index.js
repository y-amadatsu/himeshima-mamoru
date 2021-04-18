// TODO: なぜか application.jsがうまく動かない…
var dt = require('datatables.net-bs4');

$(function(){
  $('#table').DataTable({
    "paging": true,
    "lengthChange": false,
    "searching": false,
    "ordering": true,
    "info": true,
    "autoWidth": false,
  });
})