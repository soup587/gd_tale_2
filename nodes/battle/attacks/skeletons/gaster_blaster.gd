extends BaseAttack

@export var targetpos: Vector2 = Vector2(0,0)
@export var targetrot: float = 0:
	set(new):
		targetrot = deg_to_rad(new)

var stage: int = 1

func fire():
	$Collision.visible = true
	$Sprite.animation = "fire"
	$Sprite.play()
	$Collision.monitoring = true
	$Blast.play()
	await get_tree().create_timer(30/30).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	if !enabled: return
	super(delta)
	match stage:
		1:
			position.x += floor((targetpos.x - position.x) / 3)
			position.y += floor((targetpos.y - position.y) / 3)
			if position.x < targetpos.x:
				position.x += 1
			if position.x > targetpos.x:
				position.x -= 1
			if position.y < targetpos.y:
				position.y += 1
			if position.y > targetpos.y:
				position.y -= 1
			if abs(position.x - targetpos.x) < 3:
				position.x = targetpos.x
			if abs(position.y - targetpos.y) < 3:
				position.y = targetpos.y
			rotation += floor((targetrot - rotation) / 3)
			if rotation < targetrot:
				rotation += 1
			if rotation > targetrot:
				rotation -= 1
			if abs(rotation - targetrot) < 3:
				rotation = targetrot
			if abs(position.x - targetpos.x) < 0.1 && abs(position.y - targetpos.y) < 0.1 and abs(targetrot - rotation) < 0.01:
				stage = 4
				await get_tree().create_timer(7/30).timeout
				$Sprite.play()

func _ready():
	super()
	$Collision.visible = false

func _on_sprite_animation_finished() -> void:
	fire()

func _on_changed_enabled() -> void:
	$Charge.play()
