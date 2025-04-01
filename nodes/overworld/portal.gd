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

@export var TargetOffset := 20
@export_enum("Down","Right","Up","Left") var Facing := 0

func _on_area_body_entered(body: Node2D) -> void:
	if body is MainChara:
		GlobalVars.ovrwrld.change_room(Room,TargetIndex)
