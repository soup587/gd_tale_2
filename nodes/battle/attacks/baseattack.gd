class_name BaseAttack
extends Node2D

@export var damage: int

func _ready() -> void:
	get_node("Collision").body_entered.connect(print)
