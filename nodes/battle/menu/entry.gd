class_name MenuEntry
extends Node2D

var txt: String
var sel: bool
var fnc: Callable

func _ready():
	if sel:
		set_sel()
	$Point.visible = Engine.is_editor_hint()
	$Text.text = txt
	
func set_sel():
	GlobalVars.psoul.position = $Point.global_position
	GlobalVars.psoul.reset_physics_interpolation()
	sel = true

func interact():
	fnc.call()
