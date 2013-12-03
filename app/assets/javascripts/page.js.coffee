jQuery ->
  $('#chart-tabs a').click (e) ->
    e.preventDefault()
    $(@).tab('show')
    $(window).trigger('resize')
