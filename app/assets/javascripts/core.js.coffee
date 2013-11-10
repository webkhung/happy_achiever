window.behavior_selector = (behavior_name) ->
  $("*[data-behavior~=#{behavior_name}]")
jQuery ->
  $('.progressbar').progressbar {
    value: window.level[3] - level[1]
    max: window.level[2] - window.level[1]
  }

  $('#datepicker').datepicker
    dateFormat: "yy-mm-dd"

  $('.achievements').isotope
    itemSelector: '.achievement'


$(window).load ->
  if window.onLoadModal && ($onLoadModal = $(window.onLoadModal)) && $onLoadModal.length
    setTimeout ->
      $onLoadModal.removeClass('fade') if $.support.touch
      $onLoadModal.modal()
    , 500
