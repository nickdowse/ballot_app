# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(".candidate_description").on 'click', (e) ->
    $(this).toggleClass("hide")
    $(this).next().toggleClass("hide")

  $(".candidate_full_description").on 'click', (e) ->
    $(this).toggleClass("hide")
    $(this).prev().toggleClass("hide")

  $.each $('.button-checkbox'), (index, value) ->
    is_active = "glyphicon glyphicon-unchecked"
    if $(value).children('button').first().hasClass('active')
      is_active = "glyphicon glyphicon-check"
    $(value).children('button').first().prepend("<i class=\"state-icon " + is_active + "\"></i> ")
  
  $('.button-checkbox').on 'click', (e) ->
    $checkbox = $(this)
    if $checkbox.children("button").first().hasClass('active')
      e.preventDefault()
    else
      $.each $('.button-checkbox'), (index, value) ->
        $(value).children("button").first().text('Vote')
        $(value).children("button").first().removeClass('active')
        $(value).children("button").first().removeClass('btn-success')
        $(value).children("button").first().addClass('btn-default')
        $(value).children("button").first().addClass('btn-default')
        is_active = "glyphicon glyphicon-unchecked"
        if $(value).children('button').first().hasClass('active')
          is_active = "glyphicon glyphicon-check"
        $(value).children('button').first().prepend("<i class=\"state-icon " + is_active + "\"></i> ")
        
      $($checkbox).children('button').first().addClass('active')
      $($checkbox).children("button").first().addClass('btn-success')
      $($checkbox).children("button").first().removeClass('btn-default')
      $($checkbox).children('button').first().text('Voted')
      is_active = "glyphicon glyphicon-unchecked"
      if $($checkbox).children('button').first().hasClass('active')
        is_active = "glyphicon glyphicon-check"
      $($checkbox).children('button').first().prepend("<i class=\"state-icon " + is_active + "\"></i> ")

      send_off_vote($checkbox)

  organisation_id = () ->
    location.pathname.split("/")[2]

  election_id = () ->
    location.pathname.split("/")[4]

  vote_id = (checkbox) ->
    return $(checkbox).children('button').first().data('vote')

  send_off_vote = (checkbox) ->
    $.ajax({
      url:     "/organisations/#{organisation_id()}/elections/#{election_id()}/votes/#{vote_id(checkbox)}?candidate_id=#{$(checkbox).children('button').first().data('id')}",
      type:    "PATCH",
      success: (data) ->
        # here notify of successful vote
      ,
      error: (data) ->
        # here notify of unsuccessful vote
      })
