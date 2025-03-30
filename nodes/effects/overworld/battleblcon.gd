extends Node2D

func _ready() -> void:
	GlobalVars.mchara.canmove = false
	global_position = GlobalVars.mchara.global_position - Vector2(0,31)
	reset_physics_interpolation()
	
	$Timer.wait_time = ((15.0 + randf_range(0,5)))/30
	$Timer.start()
	
	await $Timer.timeout
	GlobalVars.ovrwrld.add_child(preload("res://nodes/effects/overworld/battler.tscn").instantiate())
	queue_free()
