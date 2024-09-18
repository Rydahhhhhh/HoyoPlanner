@tool
extends HTTPManager

signal request_finished(response)

func job(url: String) -> HTTPManagerJob:
	var this_job = super(url)
	this_job.on_success(request_finished.emit)
	#this_job.on_failure(request_finished.emit)
	return this_job

func fetch(url: String):
	
	job(url).fetch()
	
	var response = (await request_finished)
	while response.request_query != url:
		response = (await request_finished)
	
	return response.fetch()
