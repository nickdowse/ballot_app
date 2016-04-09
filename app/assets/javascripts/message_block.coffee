$(document).ready ->
  if $('#message_block ul li').length > 0
    $('#message_block ul li:first-child').fadeIn(800, ->
      setTimeout( ->
        $('#message_block').fadeOut(900)
      , 5000)
    )
