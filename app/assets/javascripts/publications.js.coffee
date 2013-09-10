jQuery ->
	$('#publication_keyword_tokens').tokenInput '/variables.json',
		theme: 'facebook',
		prePopulate: $('#publication_keyword_tokens').data('load'),
		preventDuplicates: true

jQuery ->
  $('#publication_target_journal_name').autocomplete
    source: $('#publication_target_journal_name').data('autocomplete-source')

jQuery ->
	$('form').on 'click', '.remove_fields', (event) ->
		$(this).prev('input[type=hidden]').val('1')
		$(this).closest('fieldset').hide()
		event.preventDefault()

	$('form').on 'click', '.add_fields', (event) ->
	  time = new Date().getTime()
	  regexp = new RegExp($(this).data('id'), 'g')
	  $(this).before($(this).data('fields').replace(regexp, time))
	  event.preventDefault()