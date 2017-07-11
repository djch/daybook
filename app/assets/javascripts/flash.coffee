# Auto-dismiss notices but not errors
document.addEventListener 'turbolinks:load', ->
  setTimeout (->
      $('.flash-content-notice').fadeOut 'fast'
      return
    ), 7000
  return
