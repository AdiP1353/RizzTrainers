extends Node2D


@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
const AUDIO_FOLDER = "res://audio/music/"

func _ready() -> void:
	randomize()  # Initialize random seed
	var audio_files = load_audio_files(AUDIO_FOLDER)
	
	if audio_files.size() > 0:
		var random_audio_file = audio_files[randi() % audio_files.size()]
		play_audio(random_audio_file)
	else:
		print("No audio files found in the specified folder.")

func load_audio_files(folder_path: String) -> Array:
	var audio_files = []
	var dir = DirAccess.open(folder_path) 
	if dir:
		print("Directory opened successfully: ", folder_path)  
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
		
			if file_name.ends_with(".mp3"):
				var full_path = folder_path + "/" + file_name  
				audio_files.append(full_path)
				print("Audio file added: ", full_path)  
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("Failed to open directory: ", folder_path) 

	return audio_files

# Function to play the selected audio file
func play_audio(file_path: String):
	var audio_stream = load(file_path) as AudioStream
	if audio_stream:
		audio_stream_player_2d.stream = audio_stream
		audio_stream_player_2d.play() 
