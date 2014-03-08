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

  # Type "<span class='orange'>Yes I can do it</span>" below
  # = text_field_tag 'name', '', { data: { behavior: 'confirm-message', message: 'Yes I can do it', unlock: 'lets-go' }, size: 150, placeholder: '', style: 'width:300px' }
  # #lets-go.hide <message>

  behavior_selector('confirm-message').keyup (e) ->
    if $(@).val().toLowerCase() == $(@).data('message').toLowerCase()
      $("##{$(@).data('unlock')}").slideDown()

  behavior_selector('disable_after_click').click (e) ->
    if $(@).data('clicked')
      e.stopPropagation()
      return false
    else
      $(@).data('clicked', true)


$(window).load ->
  if window.onLoadModal && ($onLoadModal = $(window.onLoadModal)) && $onLoadModal.length
    setTimeout ->
      $onLoadModal.removeClass('fade') if $.support.touch
      $onLoadModal.modal()
    , 500
