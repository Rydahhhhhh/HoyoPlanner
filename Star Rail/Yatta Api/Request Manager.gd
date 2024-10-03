@tool
extends HTTPManager

signal request_finished(response)

func fetch(url: String):
	var request = job(url)
	request.on_success(request_finished.emit)
	#request.on_failure(request_finished.emit)
	request.fetch()
	
	var response = (await request_finished)
	var x = response.fetch()
	while response.request_query != url:
		response = (await request_finished)
	await job_completed
	
	return response.fetch()
