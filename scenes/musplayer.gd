extends AudioStreamPlayer

func fade(out):
	create_tween().tween_property(self, "volume_linear", 0 if out else 1, 0.333)
