extends Node

const Exceptions = preload("res://Star Rail/Yatta Api/exceptions.gd")
const Character = preload("res://Star Rail/Yatta Api/models/character.gd").Character

const Language := {
	CHT = "cht",
	CN = "cn",
	DE = "de",
	EN = "en",
	ES = "es",
	FR = "fr",
	ID = "id",
	JP = "jp",
	KR = "kr",
	PT = "pt",
	RU = "ru",
	TH = "th",
	VI = "vi"
}
const BASE_URL := "https://api.yatta.top/hsr/v2"
const CACHE_PATH = "user://StarRailCache.dat"

static var lang = Language.EN
static var cache: Dictionary:
	get():
		if cache.get("Loaded", false):
			return cache
		if not FileAccess.file_exists(CACHE_PATH):
			var file = FileAccess.open(CACHE_PATH, FileAccess.WRITE)
			file.store_var({}, true)
			
		var file = FileAccess.open(CACHE_PATH, FileAccess.READ)
		cache = file.get_var(true)
		cache.Loaded = true
		return cache

static func update_cache():
	var _cache = cache
	_cache.erase("Loaded")
	
	var file = FileAccess.open(CACHE_PATH, FileAccess.WRITE)
	file.store_var(_cache, true)
	cache.Loaded = false
	return

static func request(endpoint: String, is_static: bool = false) -> Dictionary:
	var url = "{BASE_URL}/{lang}/{endpoint}".format({"lang": lang})
	if is_static:
		url = "{BASE_URL}/static/{endpoint}"
	url = url.format({"BASE_URL": BASE_URL, "endpoint": endpoint})
	
	print("Requesting %s..." % url)
	
	#print_debug("Requesting %s..." % url)
	
	return await Api.fetch(url)


static func fetch_characters(use_cache: bool = true) -> Array[Character]:
	var characters: Array[Character] = []
	
	var characters_cache = cache.get_or_add("characters", {})
	
	var last_update = characters_cache.get("last_update", null)
	var data = characters_cache.get("data", null)
	
	if null in [last_update, data]:
		use_cache = false
	else:
		var time_since_update = Time.get_unix_time_from_system() - last_update
		var days_since_update = Time.get_date_dict_from_unix_time(time_since_update).day - 1
		if days_since_update > 7:
			use_cache = false
	
	if not use_cache:
		#print(await request("avatar"))
		for c in (await request("avatar")).data.items.values():
			characters.append(Character.new(c))
		
		characters_cache.data = characters
		characters_cache.last_update = Time.get_unix_time_from_system()
		update_cache()
	
	return characters_cache.data
