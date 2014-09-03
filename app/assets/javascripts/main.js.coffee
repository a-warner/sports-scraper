(($, window) ->
  onSearchPage = $('#search-results').length > 0
  $('form#search').on({
    submit: (e) ->
      if onSearchPage
        e.preventDefault()
    keyup: (e) ->
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

  if !onSearchPage
    $('.search-query').typeahead
      source: (name for name, path of AUTOCOMPLETE_DATA),
      updater: (item) ->
        if AUTOCOMPLETE_DATA[item]
          window.location.href = AUTOCOMPLETE_DATA[item]
          'Loading...'
        else
          item
) jQuery, window
