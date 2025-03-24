class_name MenuEntry
extends Node2D

var txt: String
var sel: bool
var fnc: Callable

func _ready():
	if sel:
		set_sel()
	GlobalVars.psoul.position = $Point.global_position
	GlobalVars.psoul.reset_physics_interpolation()
	$Point.visible = Engine.is_editor_hint()
	$Text.text = txt
	
func set_sel():
	sel = true

func _physics_process(delta: float) -> void:
	#GlobalVars.psoul.position = $Point.global_position
	#GlobalVars.psoul.reset_physics_interpolation()
	pass

func interact():
	fnc.call()
