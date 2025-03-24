extends CharacterBody2D

var control = false

func onDamage():
	$snd_hurt.play()

func _ready():
	PlayerVars.plrdamage.connect(onDamage)

func _physics_process(d):
	if PlayerVars.inv > 0:
		$Sprite.speed_scale = 0.5
	else:
		$Sprite.speed_scale = 0
		$Sprite.frame = 0
	
	velocity = Vector2(0,0)
	
	if control:
		if Input.is_action_pressed("Up"):
			velocity.y -= PlayerVars.spd*30
		if Input.is_action_pressed("Down"):
			velocity.y += PlayerVars.spd*30
		if Input.is_action_pressed("Left"):
			velocity.x -= PlayerVars.spd*30
		if Input.is_action_pressed("Right"):
			velocity.x += PlayerVars.spd*30

	move_and_slide()

func _input(evt: InputEvent):
	if evt.is_action_pressed("Confirm"):
		if $Interactor.get_overlapping_areas():
			var intr = $Interactor.get_overlapping_areas()[0].get_parent()
			if intr and intr.has_method("_on_interact"):
				intr._on_interact()
