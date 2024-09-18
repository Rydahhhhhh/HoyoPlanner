extends Node


static func format_str(text: String) -> String:
	var clean = RegEx.create_from_string(r"<.*?>|\{SPRITE_PRESET#[^\}]+\}")
	return remove_ruby_tags(replace_pronouns(clean.sub(text, "").replace("\\n", "\n")))

static func find_next_letter(text: String, placeholder: String) -> String:
	"""Find the next letter after a placeholder in a string"""
	var index = text.find(placeholder)
	index += len(placeholder)
	return text[index]

static func replace_placeholders(string: String, params: Variant) -> String:
	if params == null:
		return string
	
	if params is Array:
		for i in len(params):
			var value: int = params[i]
			var placeholder = "#i[%i]" % i
			if placeholder in string:
				var value_ = value * 100 if find_next_letter(string, placeholder) == "%" else value
				string = string.replace(placeholder, str(value_))
		return string
	
	for item in params.items():
		var key: String = item[0]
		var values: Array = item[1]
		var value = values[0]
		var placeholder = "#{%s}[i]"
		if placeholder in string:
			if find_next_letter(string, placeholder) == "%":
				value *= 100
			string = string.replace(placeholder, str(value))
	return string

static func replace_pronouns(text: String) -> String:
	var female_pronoun_pattern := RegEx.create_from_string(r"\{F#(.*?)\}")
	var male_pronoun_pattern := RegEx.create_from_string(r"\{M#(.*?)\}")
	
	var female_pronoun_match := female_pronoun_pattern.search(text)
	var male_pronoun_match := male_pronoun_pattern.search(text)
	
	if female_pronoun_match and male_pronoun_match:
		var female_pronoun = female_pronoun_match.group(1)
		var male_pronoun = male_pronoun_match.group(1)
		var replacement = "{%s}/{%s}" % [female_pronoun, male_pronoun]
		
		text = female_pronoun_pattern.sub(text, replacement)
		text = male_pronoun_pattern.sub(text, replacement)
		text = text.replace("#", "")

	return text

static func remove_ruby_tags(text: String) -> String:
	# Remove {RUBY_E#} tags
	text = RegEx.create_from_string(r"\{RUBY_E#\}").sub(text, "")
	# Remove {RUBY_B...} tags
	text = RegEx.create_from_string(r"\{RUBY_B[^}]*\}").sub(text, "")
	return text
