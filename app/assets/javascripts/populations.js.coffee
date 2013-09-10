jQuery ->
	$('#publication_population_tokens').tokenInput '/populations.json',
		theme: 'facebook',
		prePopulate: $('#publication_population_tokens').data('load'),
		preventDuplicates: true