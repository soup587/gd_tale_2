extends Node2D

func _ready() -> void:
	AudioPlayer.play(preload("res://snd/battlefall.wav"))
	global_position = GlobalVars.mchara.global_position - Vector2(0,20)
	
	Encounters.start_encounter(null, 2)
