$('.autoplay').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 2500,
    prevArrow: "<div class='ok'><img class='a-left control-c prev slick-prev' src='img/icon25.png'></div>",
    nextArrow: "<div class='ok2'><img class='a-right control-c next slick-next' src='img/icon26.png'></div>"
});

var swiperH = new Swiper('.swiper-container-h', {
    spaceBetween: 50,
    pagination: {
        el: '.swiper-pagination-h',
        clickable: true,
    },
});
var swiperV = new Swiper('.swiper-container-v', {
    direction: 'vertical',
    spaceBetween: 50,
    pagination: {
        el: '.swiper-pagination-v',
        clickable: true,
    },
});