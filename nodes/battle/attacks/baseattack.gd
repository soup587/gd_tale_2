class_name BaseAttack
extends Node2D

## Whether the attack should process and be visible or not.
@export var enabled: bool = true

## How long it takes for the attack to become enabled.[br]
## A value of -1 disables this functionality.[br]
@export var delay: int = -1

@export var damage: int

var collider: CollisionObject2D

var colliding: bool = false

signal changed_enabled

func set_enabled(state: bool):
	if state:
		changed_enabled.emit()
	set_process(state)
	visible = state
	enabled = state

func _ready() -> void:
	if Engine.is_editor_hint(): return
	collider = get_node("Collision")
	collider.body_entered.connect(func(_a): colliding = true)
	collider.body_exited.connect(func(_a): colliding = false)
	if $ScreenBox:
		$ScreenBox.screen_exited.connect(queue_free)
	if delay != -1:
		set_enabled(false)
		await get_tree().create_timer(float(delay)/30.0).timeout
		set_enabled(true)
	
func _physics_process(delta: float) -> void:
	if !enabled: return
	if colliding:
		PlayerVars.damage_player(damage)
