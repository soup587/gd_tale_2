extends Node2D

func _ready():
	GlobalVars.ovrwrld = self
	GlobalVars.mplayer = $BGM
	GlobalVars.mplayer.play()
	change_room("ruins/1")

func deinst():
	pass

func reinst():
	GlobalVars.mplayer = $BGM
	GlobalVars.mplayer.play()
	$Transition.trigger()
	$Map.set_modulate(Color.WHITE)
	GlobalVars.mchara.canmove = true

func change_room(pth, id = null):
	if !ResourceLoader.exists("res://scenes/overworld/"+pth+".tscn"):
		push_error("Map '"+pth+"' doesn't exist!")
		return
	$Transition.trigger(true)
	GlobalVars.mchara.canmove = false
	await $Transition.done
	$Map.get_child(0).queue_free()
	
	await get_tree().physics_frame
	var ms = load("res://scenes/overworld/"+pth+".tscn").instantiate()
	for n in ms.get_node("Portals").get_children():
		if n.Index == id:
			GlobalVars.mchara.velocity = Vector2.ZERO
			GlobalVars.mchara.global_position = n.global_position + n.TargetOffset
			GlobalVars.mchara.reset_physics_interpolation()
			GlobalVars.mchara.turn(n.Facing)
			break
	
	var i := 0
	for v in ms.CameraLimits:
		GlobalVars.mchara.cam.set_limit(i, v if v != -1 else (-10000000 if (i == 0 or i == 1) else 10000000))
		i += 1
	GlobalVars.mchara.cam.reset_physics_interpolation()
	
	$Map.add_child(ms)
	
	$Transition.trigger()
	GlobalVars.mchara.canmove = true
