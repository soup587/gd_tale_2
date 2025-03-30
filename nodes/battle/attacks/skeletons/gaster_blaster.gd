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
	AudioPlayer.play(load("res://snd/rainbowbeam_1.wav"),0.8,1.2)
	AudioPlayer.play(load("res://snd/gigatalk.wav"),0.6,1.2)
	if get_viewport().get_camera_2d():
		get_viewport().get_camera_2d().shake(10)
	
	retreatspeed = 1
	
var retreatspeed: float = 0
var fade: float = 1
var beamt: float = 0
var beamsine: float = 0
var beamb: float = 0

var beamtimer: int = 0

func _physics_process(delta: float) -> void:
	if !enabled: return
	super(delta)
	if retreatspeed:
		
		beamtimer += 1
		
		if beamtimer < 5:
			retreatspeed += 1
			beamt += floor(35 * scale.x / 4)
		else:
			retreatspeed += 4
		
		if beamtimer > 7:
			beamt *= 0.8
			fade -= 0.1
			$Collision.modulate.a = fade
			if beamt <= 2:
				queue_free()
			
		if fade < 0.8:
			$Collision.monitoring = false
			
		position += Vector2(retreatspeed,0).rotated(rotation - deg_to_rad(90))
		beamsine += 0.5
		beamb = (sin(beamsine / 1.5) * (beamt/4))
		$Collision/Beamcircle.scale.x = beamb/16
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
