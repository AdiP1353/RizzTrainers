extends CanvasLayer

var power_words = [
	"entrepreneur", "strive", "ai", "experienced", "passionate", "creative", "strategic", "skilled", "motivated", "leadership", "expert", "specialised", "success", "successful", "agile", "intentional",
	"bridging", "diverse", "diversity", "inclusivity", "remote", "organisation", "revenue", "like", "share", "payoneer", "family", "network", "neural", "opportunity", "introducing", "innovation",
	"turnover", "toxic", "illustrating", "projection", "stage", "introducing", "new", "era", "heights", "reflect", "reflecting", "revolutionizing", "revoluntionising", "cutting", "edge", "collaborative",
	"inclusive", "innovated", "product", "takeaways", "networking", "profits", "divert", "portfolio", "innovative", "technological", "newsletter", "new", "handson", "forwardthinking", "talent", "acquisition",
	"team", "announce", "proud", "scholarships", "olympiad", "build", "enhance", "exclusive", "free", "exciting", "interviews", "difference", "growth", "here", "ask", "repost", "stack", "hands", "down", "truth",
	"surprising", "loyal", "loyalty", "encourage", "today", "promote", "culture", "hard", "work", "values", "inspire", "transform", "curveballs", "curveball", "lucky", "incredible", "red", "flag",
	"delighted", "startup", "environmentally", "partner", "partnership", "partnered", "thrive", "strengths", "strength", "push", "pushed", "empower", "iconic", "stepped", "achieve", "achievement", "achievements",
	"raise", "proactive", "over", "past", "last", "ceo", "exciting", "followup", "recruiter", "company", "linkedin", "journey", "money", "infrastructure", "access", "im", "thrilled", "create", "introduce", "constructive",
	"optimize", "optimise", "efficient", "newsletter", "informed", "innovators", "accessibility", "salaries", "responsible", "respect", "bigger", "brighter", "cultivates", "accountable", "collaboration", "empathy",
	"paycheck", "career", "weaknesses"
]

func min(a, b):
	if a > b:
		return b
	return a

# Function to remove punctuation from a string
func remove_special_symbols(input_string: String) -> String:
	var characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	var result = ""
	for c in input_string:
		if c in characters:
			result += c
			
	return result

func is_numeric(str):
	var chars = "0123456789"
	
	for c in remove_special_symbols(str):
		if c not in chars:
			return false
			
	return true
	
func is_hashtag(str):
	if str != "" && str[0] == "#":
		return true
		
	return false

func has_link(str):
	if "http" in str:
		return true
	return false
	
func calc_score(post):
	var dupes = {}
	var rng = RandomNumberGenerator.new()
	var words = post.to_lower().replace("\n", " ").split(" ")
	var score = 0.0
	var buzzwords = 0
	
	print(len(words))
	
	for x in words:
		if has_link(x):
			score *= 1.05
		if is_hashtag(x):
			score *= 1.1
		
		if remove_special_symbols(x) in power_words:
			buzzwords += 1
			if dupes.has(x):
				score -= 0.1
			elif is_numeric(x):
				score *= 1.05
			else:
				score += rng.randf_range(0.7, 0.9)
				dupes[x] = true
				
	if ((len(words) + 1) / 2) < buzzwords:
		score *= 1.05
			
	print("Score: ", score)
	print("Buzzwords: ", buzzwords)
	var my_random_number = rng.randf_range(0.8, 0.95)
	if buzzwords == 0: buzzwords = 1
	
	if len(words) < 70:
		var penalty = 0.014 * float(len(words))
		print ("Penalty: ", penalty) 
		score *= penalty
	
	return min((score) / buzzwords, 1)  * my_random_number 

func _on_node_2d_button_pressed() -> void:
	var post = $Panel/TextEdit.text
	var score = calc_score(post) * 100
	
	$Panel/Label.text = "LinkedIn Post Score: " + str(score) + "%"
