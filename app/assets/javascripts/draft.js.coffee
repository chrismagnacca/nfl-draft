# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#position-list').on('change', (event) ->
    position = $('#position-list option:selected').val()
    $.ajax '/players/filter',
      type: 'POST',
      dataType: 'json',
      data: {position: position},
      error: (jqXHR, textStatus, error) ->

      success: (data, textStatus, jqXHR) ->
        $('#undrafted-players').html(data.html)
  )
