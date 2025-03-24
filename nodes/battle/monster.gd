@tool
@icon("res://editor/msoul.svg")
class_name Monster
extends Node2D

@export var sprite: PackedScene:
	set(new):
		var n = new.instantiate()
		add_child(n)
		
		sprite = new

func _ready():
	pass
