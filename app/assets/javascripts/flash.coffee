document.addEventListener 'turbolinks:load', ->
  setTimeout (->
      $('.flash').fadeOut 'fast'
      return
    ), 7000
  return
