extends Node2D

func _ready() -> void:
	GlobalVars.mchara.visible = false
	AudioPlayer.play(preload("res://snd/battlefall.wav"))
	$Sprite.global_position = GlobalVars.mchara.global_position - Vector2(0,10)
	$Sprite.reset_physics_interpolation()
	var tween = create_tween()
	tween.tween_property($Sprite, "global_position", Vector2((24), 235), 0.56666666666)
	await tween.finished
	await get_tree().create_timer(5/30).timeout
	GlobalVars.mchara.visible = true
	queue_free()
	Encounters.start_encounter(null, 2)
