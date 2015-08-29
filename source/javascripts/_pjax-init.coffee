$(document).pjax '[data-pjax]', '#page-content',
  fragment: '#page-content'
  scrollTo: false
.on 'ready pjax:end', (xhr, options) ->
  if window.location.pathname == $(document.body).data 'baseurl'
    $('#drawer').hide()
  else
    $('#drawer').show()
