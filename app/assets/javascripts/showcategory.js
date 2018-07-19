$(document).on('turbolinks:load', function(){
  $('.change_cate').click(function(){
    cate_id = $(this).attr('cate-id');
    $(this).addClass("current");
    $(this).parent().siblings().children().removeClass("current");
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

  $('#search_auto_complete').bind('focus keyup', function() {
    var search = $(this).val();
    if (search != '')
    {
      $('.result_search').fadeIn();
        $.ajax({
        url: 'searh_autocomplete',
        method: 'GET',
        data: { search: search }
      })
    }
    else
      $('.result_search').fadeOut();
  })

  $('#seach').click(function(e) {
    e.preventDefault();
    $('.search').slideToggle();
  });

  $('.all_image_table ul li>img').each(function(){
    $(this).click(function(){
      var url = $(this).attr('src');
      $(this).parent().parent().parent().siblings().children().attr('src',url);
    });
  });
});
$(document).click(function(event) {
  if (!$(event.target).closest('#search_auto_complete,.result_search').length) {
    $('.result_search').hide();
    $('#search_auto_complete').attr('style', 'width: 130px')
  } else
  $('#search_auto_complete').attr('style', 'width: 100%')
});
$(window).load(function () {
  $('.wrapper').addClass('loaded');
  setTimeout(function(){
    $('.wrapper').attr('style',"display:none");
  },2000)
});
