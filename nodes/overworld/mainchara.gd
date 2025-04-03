class_name MainChara
extends CharacterBody2D

var facing := 0 
var turned := false
var canmove := true

var moving := false

var sliding = false

@onready var sprite = $Sprite
@onready var interactor = $Interact
@onready var cam = $Camera

func _ready() -> void:
	GlobalVars.mchara = self

func turn(i):
	facing = i
	match facing:
		0:
			sprite.animation = "down"
			interactor.get_child(0).set_deferred("disabled", false)
			interactor.get_child(1).set_deferred("disabled", true)
			interactor.get_child(2).set_deferred("disabled", true)
			interactor.get_child(3).set_deferred("disabled", true)
		1:
			sprite.animation = "right"
			interactor.get_child(0).set_deferred("disabled", true)
			interactor.get_child(1).set_deferred("disabled", false)
			interactor.get_child(2).set_deferred("disabled", true)
			interactor.get_child(3).set_deferred("disabled", true)
		2:
			sprite.animation = "up"
			interactor.get_child(0).set_deferred("disabled", true)
			interactor.get_child(1).set_deferred("disabled", true)
			interactor.get_child(2).set_deferred("disabled", false)
			interactor.get_child(3).set_deferred("disabled", true)
		3:
			sprite.animation = "left"
			interactor.get_child(0).set_deferred("disabled", true)
			interactor.get_child(1).set_deferred("disabled", true)
			interactor.get_child(2).set_deferred("disabled", true)
			interactor.get_child(3).set_deferred("disabled", false)
	
func _unhandled_input(event: InputEvent) -> void:
	if !canmove: return
	if !event.is_action_pressed("Confirm"): return
	var ies = interactor.get_overlapping_bodies()
	for v in ies:
		if (v is Interactable):
			v._on_interact()
			

var prevpos := Vector2.ZERO

func _physics_process(delta: float) -> void:
	if !sliding:
		velocity = Vector2.ZERO
	
	var left = Input.is_action_pressed("Left")
	var up = Input.is_action_pressed("Up")
	var right = Input.is_action_pressed("Right")
	var down = Input.is_action_pressed("Down")
	
	if canmove:
		if left:
			turned = true
			
			velocity.x -= (30*(2 if (prevpos.x == (position.x-3)) else 3))
			
			if up and facing == 2:
				turned = false
			if down and facing == 0:
				turned = false
			if turned:
				turn(3)
		
		elif right:
			turned = true
			
			velocity.x += (30*(2 if (prevpos.x == (position.x-3)) else 3))
			
			if up and facing == 2:
				turned = false
			if down and facing == 0:
				turned = false
			if turned:
				turn(1)
				
		if up:
			turned = true
			
			velocity.y -= (30*3)
			
			if right and facing == 1:
				turned = false
			if left and facing == 3:
				turned = false
			if turned:
				turn(2)
		
		elif down:
			turned = true
			
			velocity.y += (30*3)
			
			if right and facing == 1:
				turned = false
			if left and facing == 3:
				turned = false
			if turned:
				turn(0)
	
	if velocity != Vector2.ZERO:
		sprite.play()
	else:
		sprite.stop()
		sprite.frame = 0
	move_and_slide()
	prevpos = position
