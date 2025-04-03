extends Node2D

var clap := 0
var on := false

var timer := 2

@onready var fheart := $FakeHeart

func _ready():
	GlobalVars.ovrwrld.get_node("Map").set_modulate(Color.BLACK)
	GlobalVars.mplayer.stream_paused = true
	fheart.global_position = GlobalVars.mchara.global_position - Vector2(0,10)
	
func _physics_process(delta: float) -> void:
	timer -= 1
	if timer != 0: return
	
	if !on:
		if fheart.visible:
			fheart.visible = false
			on = true
			clap += 1
		else:
			AudioPlayer.play(preload("res://snd/noise.wav"))
			on = true
			fheart.visible = true
	on = false
	
	if clap > 2:
		GlobalVars.ovrwrld.get_node("Transition").visible = true
		GlobalVars.ovrwrld.add_child(preload("res://nodes/effects/overworld/transheart.tscn").instantiate())
		queue_free()
	else:
		timer = 2
