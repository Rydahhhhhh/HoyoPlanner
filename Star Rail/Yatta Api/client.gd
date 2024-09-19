extends Node

const Exceptions = preload("res://Star Rail/Yatta Api/exceptions.gd")

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

#func _ready() -> void:
	#DirAccess.remove_absolute(CACHE_PATH)

var lang = Language.EN
var cache: Dictionary:
	get():
		if cache.get("Loaded", false):
			return cache
		if not FileAccess.file_exists(CACHE_PATH):
			FileAccess.open(CACHE_PATH, FileAccess.WRITE).store_var({}, true)
			
		cache = FileAccess.open(CACHE_PATH, FileAccess.READ).get_var(true)
		cache.Loaded = true
		return cache

func update_cache():
	var _cache = cache
	_cache.erase("Loaded")
	
	FileAccess.open(CACHE_PATH, FileAccess.WRITE).store_var(_cache, true)
	
	cache.Loaded = false
	print(cache)
	return

func request(endpoint: String, is_static: bool = false) -> Dictionary:
	var url = "{BASE_URL}/{lang}/{endpoint}".format({"lang": lang})
	if is_static:
		url = "{BASE_URL}/static/{endpoint}"
	url = url.format({"BASE_URL": BASE_URL, "endpoint": endpoint})
	
	print("Requesting %s..." % url)
	
	#print_debug("Requesting %s..." % url)
	
	return await Api.fetch(url)

func validate_cache(key):
	var cached_data = cache.get_or_add(key, {})
	
	var last_update = cached_data.get("last_update", null)
	var data = cached_data.get("data", null)
	
	var use_cache = true
	if null in [last_update, data]:
		use_cache = false
	else:
		var time_since_update = Time.get_unix_time_from_system() - last_update
		var days_since_update = Time.get_date_dict_from_unix_time(time_since_update).day - 1
		if days_since_update > 7:
			use_cache = false
	
	#if not use_cache:
		#for c in (await request("avatar")).data.items.values():
			#characters.append(SrCharacter.new(c))
		#characters_cache.data = characters
		#characters_cache.last_update = Time.get_unix_time_from_system()
		#update_cache()
	#else:
		#print("Using cache for 'fetch_characters'")
	#return characters_cache.data
	
	return use_cache

func fetch_characters(use_cache: bool = true) -> Array[SrCharacter]:
	var characters_cache: YattaCache = cache.get_or_add("characters", YattaCache.new())
	
	if not use_cache or characters_cache.invalid:
		var characters: Array[SrCharacter] = []
		for c in (await request("avatar")).data.items.values():
			characters.append(SrCharacter.new(c))
		
		characters_cache.data = characters
		update_cache()
	else:
		print("Using cache for 'fetch_characters'")
	
	return characters_cache.data

func fetch_character_detail(id: int, use_cache: bool = true):
	var character_details: Dictionary = cache.get_or_add("character detail", {})
	var character_detail_cache: YattaCache = character_details.get_or_add(id, YattaCache.new())
	
	if not use_cache or character_detail_cache.invalid:
		var data = (await request("avatar/%s" % id)).data
		character_detail_cache.data = SrCharacterDetail.new(data)
		update_cache()
	else:
		print("Using cache for 'fetch_character_detail'")
	
	ResourceSaver.save(character_detail_cache.data, 'lingsha.tres')
	
	return character_detail_cache.data

	#var character_detail_cache = cache.get("character_detail")
	
	#var last_update = character_detail_cache.get("last_update", null)
	#var data = character_detail_cache.get("data", null)
	#
	#if null in [last_update, data]:
		#use_cache = false
	#else:
		#var time_since_update = Time.get_unix_time_from_system() - last_update
		#var days_since_update = Time.get_date_dict_from_unix_time(time_since_update).day - 1
		#if days_since_update > 7:
			#use_cache = false
	#
	#if not use_cache:
		##for c in (await request("avatar")).data.items.values():
			##characters.append(SrCharacter.new(c))
		##character_detail_cache.data = characters
		##character_detail_cache.last_update = Time.get_unix_time_from_system()
		#update_cache()
	#else:
		#print("Using cache for 'fetch_characters'")
	#return character_detail_cache.data
