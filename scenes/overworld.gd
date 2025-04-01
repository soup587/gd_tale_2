extends Node2D

func _ready():
	GlobalVars.ovrwrld = self
	change_room("ruins/1")

func change_room(pth, id = null):
	$Map.get_child(0).queue_free()
	
	await get_tree().physics_frame
	$Map.add_child(load("res://scenes/overworld/"+pth+".tscn").instantiate())
