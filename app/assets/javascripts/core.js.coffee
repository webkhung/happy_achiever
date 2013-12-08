window.behavior_selector = (behavior_name) ->
  $("*[data-behavior~=#{behavior_name}]")
jQuery ->
#  $('.progressbar').progressbar {
#    value: window.level[3] - level[1]
#    max: window.level[2] - window.level[1]
#  }

  $('#datepicker').datepicker
    dateFormat: "yy-mm-dd"

  $('.achievements').isotope
    itemSelector: '.achievement'

  $("*[rel~=tooltip], .tooltip").tooltip()

  behavior_selector('next-step').click (e) ->
    e.preventDefault()

    if $(@).attr('disabled')
      return

    step = parseInt($(@).closest('.step').attr('id').substring('5'))

    $(@).closest('.step').slideUp ->
      $("#step-#{step+1}").slideDown()

  behavior_selector('previous-step').click (e) ->
    e.preventDefault()

    step = parseInt($(@).closest('.step').attr('id').substring('5'))

    $(@).closest('.step').slideUp ->
      $("#step-#{step-1}").slideDown()

  behavior_selector('confirm-message').keyup (e) ->
    if $(@).val().toLowerCase() == $(@).data('message').toLowerCase()
      $("##{$(@).data('unlock')}").slideDown()

$(window).load ->
  if window.onLoadModal && ($onLoadModal = $(window.onLoadModal)) && $onLoadModal.length
    setTimeout ->
      $onLoadModal.removeClass('fade') if $.support.touch
      $onLoadModal.modal()
    , 500
