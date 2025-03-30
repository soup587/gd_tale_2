extends BaseAttack

@onready var sprite: Sprite2D = $Sprite

var giga := false
var ss := 0.0
var ac := randf()*255

var add := 0


func _on_enabled():
	sprite.frame = randi_range(0,1)
	sprite.modulate = Color.from_hsv(ac/255,0.82,1)
	await get_tree().process_frame
	var p
	if !giga:
		p = randf_range(0.75,1)
	else:
		p = randf_range(0.6,0.8)
	if get_viewport().get_camera_2d():
		get_viewport().get_camera_2d().shake(3)
	AudioPlayer.play(load("res://snd/lithit.wav"),0.8, p)

func _physics_process(delta: float) -> void:
	if !enabled: return
	super(delta)
	position.x += (randi_range(0,6) - randi_range(0,6))
	position.y += (randi_range(0,6) - randi_range(0,6))
	reset_physics_interpolation()
	
	if giga:
		ss -= 0.5
		position.x += (randi_range(0,12) - randi_range(0,12))
		position.y += (randi_range(0,12) - randi_range(0,12))
		
	ss += 1
	if ss > 2:
		sprite.modulate.a -= 0.1
		if sprite.modulate.a < 0.5:
			sprite.scale.x -= 0.2
		if sprite.modulate.a < 0.1:
			queue_free()
	add += 10
	sprite.modulate.r = (ac + add) / 255
	sprite.modulate.g = 0.82
	
	if sprite.modulate.a < 0.8:
		$Collision.visible = false
		$Collision.monitoring = false
