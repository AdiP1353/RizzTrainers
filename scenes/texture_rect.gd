extends TextureRect




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tw = self.create_tween().set_loops()
	tw.tween_property(self, "scale", scale * 1.1, 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	tw.tween_property(self, "scale", scale * 0.9, 1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
