extends Node

func YattaAPIError(code: int) -> void:
	push_error("An error occurred while requesting the API, status code: %i" % code)

func DataNotFoundError():
	push_error("Data not found")

func ConnectionTimeoutError():
	push_error("Connection to the API timed out")
