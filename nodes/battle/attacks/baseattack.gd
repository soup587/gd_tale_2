class_name BaseAttack
extends Node2D

## Whether the attack should process and be visible or not.
@export var enabled: bool = true

## How long it takes for the attack to become enabled.[br]
## A value of -1 disables this functionality.[br]
@export var delay: int = -1

@export var damage: int

@export_enum("White", "Blue","Orange") var color: int = 0:
	set(new):
		match new:
			0:
				modulate = Color(1,1,1)
			1:
				modulate = Color(0, 0.635, 0.91)
			2:
				modulate = Color(0.988, 0.65, 0)
		color = new

var collider: CollisionObject2D

var colliding: bool = false

signal changed_enabled

func set_enabled(state: bool):
	if state:
		changed_enabled.emit()
		reset_physics_interpolation()
	set_process(state)
	visible = state
	enabled = state

func _ready() -> void:
	var dtimer = Timer.new()
	dtimer.one_shot = true
	add_child(dtimer)
	
	if Engine.is_editor_hint(): return
	collider = get_node("Collision")
	collider.body_entered.connect(func(_a): colliding = true)
	collider.body_exited.connect(func(_a): colliding = false)
	if $ScreenBox:
		$ScreenBox.screen_exited.connect(queue_free)
	if delay > -1:
		set_enabled(false)
		dtimer.wait_time = (float(delay)/30.0)
		dtimer.start()
		await dtimer.timeout
		set_enabled(true)
	
func _physics_process(delta: float) -> void:
	if !enabled: return
	if colliding:
		match color:
			0:
				PlayerVars.damage_player(damage)
			1:
				if GlobalVars.psoul.velocity.length() > 0:
					PlayerVars.damage_player(damage)
			2:
				if !GlobalVars.psoul.velocity.length() > 0:
					PlayerVars.damage_player(damage)
