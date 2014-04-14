jQuery ->
  behavior_selector('show-comments').click (e) ->
    e.preventDefault()
    $(@).parent('.comments').find('p').slideDown()
