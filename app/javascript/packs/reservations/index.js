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
    "responsive": true,
    "sProcessing": "処理中...",
    "sLengthMenu": "_MENU_ 件表示",
    "sZeroRecords": "データはありません。",
    "sInfo": " _TOTAL_ 件中 _START_ から _END_ まで表示",
    "sInfoEmpty": " 0 件中 0 から 0 まで表示",
    "sInfoFiltered": "（全 _MAX_ 件より抽出）",
    "sInfoPostFix": "",
    "sSearch": "検索:",
    "sUrl": "",
    "oPaginate": {
      "sFirst": "先頭",
      "sPrevious": "前",
      "sNext": "次",
      "sLast": "最終"
    },
    //"sDom": '<"datatables-header pull-right"lfpi>rt<"datatables-footer pull-right"pi>'
  });
})