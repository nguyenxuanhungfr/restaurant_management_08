$(document).ready(function(){
  $('.change_cate').click(function(){
    cate_id = $(this).attr('cate-id');
    $.ajax({
      url: 'show_category',
      method: 'GET',
      data: {cate_id: cate_id},
      beforeSend: function() {
        $('.loading').attr('style','display:block');
      },
      complete: function() {
        $('.loading').attr('style','display:none');
      }
    });
  });
});
