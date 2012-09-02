(($) ->
  $('form#search').on('submit', (e) ->
    e.preventDefault()
    query = $(this).find('.search-query').val()
    request = $.ajax({
      url: '/search',
      type: 'POST',
      data: { query: query },
    })
    request.done( (results) ->
      $('#search-results').html(results)
    )
    request.error( ->
      alert("There was an error!")
    )
  )
) jQuery
