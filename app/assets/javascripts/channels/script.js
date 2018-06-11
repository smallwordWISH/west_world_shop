$(document).on('turbolinks:load', function() {
  $('.cart-panel .close-btn').click(function() {
    $(this).parents('.cart-panel').css('transform', 'translateX(0)');
  });

  $('nav .menu .cart-btn').click(function() {
    $('.cart-panel').css('transform', 'translateX(-100%)');
  });
});