window.behavior_selector = (behavior_name) ->
  $("*[data-behavior~=#{behavior_name}]")
