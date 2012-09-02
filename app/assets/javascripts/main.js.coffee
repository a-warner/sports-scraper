(($, window) ->
  onSearchPage = $('#search-results').length > 0
  $('form#search').on({
    submit: (e) ->
      if onSearchPage
        e.preventDefault()
    keypress: (e) ->
      if onSearchPage
        query = $(this).find('.search-query').val()
        request = $.ajax({
          url: '/search',
          type: 'POST',
          data: { query: query },
        })
        request.success( (results) ->
          $('#search-results').html(results)
        )
        request.error( ->
          alert("There was an error!")
        )
  })
) jQuery, window
