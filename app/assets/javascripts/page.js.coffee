chart_mouse_over = ->
  $("#chart-hover-text").html @reasons
  $("#chart-hover-text").show()
chart_mouse_out = ->
  $("#chart-hover-text").hide()
column_formatter = ->
  names = @point.stateNames.split(",")
  imagePaths = @point.imagePaths.split(",")
  html = ""
  i = 0
  i = 0
  while i < names.length
    html += names[i] + "<div class=\"text-center\"><img src=\"" + imagePaths[i] + "\"></div>"
    i++
  "<div class=\"chart-image\">" + html + "</div>"

jQuery ->
  $('#graph-tabs a').click (e) ->
    e.preventDefault()
    $(@).tab('show')
    $(window).trigger('resize')
