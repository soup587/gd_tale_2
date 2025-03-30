extends Node2D

func _ready():
	AudioPlayer.play(load("res://snd/laz1.wav"))

func _on_sprite_animation_finished() -> void:
	GlobalVars.battle.monster_hit.emit()
	queue_free()
