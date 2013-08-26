window.behavior_selector = (behavior_name) ->
  $("*[data-behavior~=#{behavior_name}]")
jQuery ->
  $('#progressbar').progressbar {
    value: window.level[3] - level[1]
    max: window.level[2] - window.level[1]
  }
