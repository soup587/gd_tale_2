class_name BasicVelocityAttack
extends BaseAttack

@export_range(-360,360,1,"degrees") var direction = 0
@export var speed = 0

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	position += Vector2(speed,0).rotated(deg_to_rad(direction))
	super(delta)
