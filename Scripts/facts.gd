extends Node

var country_facts = []

func _ready():
	load_country_facts()
	show_random_country_fact()

func load_country_facts():
	var file = FileAccess.open("res://Scripts/countries.json", FileAccess.WRITE)
	file.open("res://Scripts/countries.json", FileAccess.READ)
	var data = file.get_as_text()
	country_facts = JSON.parse_string(data)
	file.close()

func show_random_country_fact():
	if country_facts.size() > 0:
		var random_fact = country_facts[randi() % country_facts.size()]
		print("Country: %s" % random_fact["country"])
		print("Capital: %s" % random_fact["capital"])
		print("Population: %d" % random_fact["population"])
		print("Language: %s" % random_fact["language"])
		print("Fact: %s" % random_fact["fact"])
