$(document).on('turbolinks:load', function() {
  $(document).on('click', '.cart-panel .close-btn', function() {
    $(this).parents('.cart-panel').css('transform', 'translateX(0)');
  });

  $('nav').on('click', '.menu .cart-btn', function() {
    $('.cart-panel').css('transform', 'translateX(-100%)');
  });
});