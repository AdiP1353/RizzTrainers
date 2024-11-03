extends Node2D
signal button_pressed

func _on_button_pressed() -> void:
	emit_signal("button_pressed")  # Emit the custom signal
