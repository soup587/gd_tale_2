extends Node2D

var clap := 0
var on := false

var timer := 2

func _ready():
	GlobalVars.ovrwrld.get_node("Map").modulate = Color(0,0,0)
	$FakeHeart.global_position = GlobalVars.mchara.global_position - Vector2(0,20)
	
func _physics_process(delta: float) -> void:
	timer -= 1
	if timer != 0: return
	
	if !on:
		if $FakeHeart.visible:
			$FakeHeart.visible = false
			on = true
			clap += 1
		else:
			AudioPlayer.play(preload("res://snd/noise.wav"))
			on = true
			$FakeHeart.visible = true
	on = false
	
	if clap > 2:
		GlobalVars.ovrwrld.get_node("NPCs").get_node("Transition").visible = true
		GlobalVars.ovrwrld.add_child(preload("res://nodes/effects/overworld/transheart.tscn").instantiate())
	else:
		timer = 2
