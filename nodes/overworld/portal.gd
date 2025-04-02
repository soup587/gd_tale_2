@tool
class_name Portal
extends Node2D

@export var Index := 0

@export var Size := Vector2(20,20):
	set(v):
		if !is_node_ready():
			await ready
		$Area/Box.shape.size = v
		Size = v

@export var Room := ""

@export var TargetIndex := 0

@export_enum("Down","Right","Up","Left") var Facing := 0:
	set(v):
		match v:
			0:
				$Preview.animation = "down"
			1:
				$Preview.animation = "right"
			2:
				$Preview.animation = "up"
			3:
				$Preview.animation = "left"
		Facing = v

@export var TargetOffset := Vector2(0,0):
	set(v):
		$Preview.position = v
			
		TargetOffset = v

var active := false

func _ready():
	$Preview.visible = Engine.is_editor_hint()
	await get_tree().physics_frame
	active = true

func _on_area_body_entered(body: Node2D) -> void:
	if !active: return
	if body is MainChara:
		GlobalVars.ovrwrld.change_room(Room,TargetIndex)
