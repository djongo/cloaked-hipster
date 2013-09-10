jQuery ->
	$('#publication_survey_tokens').tokenInput '/surveys.json',
		theme: 'facebook',
		prePopulate: $('#publication_survey_tokens').data('load'),
		preventDuplicates: true