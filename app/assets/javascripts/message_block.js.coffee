$(document).ready ->
  if $('#message_block ul li').length > 0
    $('#message_block ul li:first-child').fadeIn(800, ->
      setTimeout( ->
        $('#message_block ul li').fadeOut(900)
      , 10000)
    )
  $('.flash_messages').on 'click', 'li', ->
    $(this).fadeOut(500)
