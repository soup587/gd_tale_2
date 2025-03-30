extends Node2D

var siner = 0.0
var xoff = 0.0
var yoff = 0.0

@onready var head = $Sprite/Head
@onready var torso = $Sprite/Torso
@onready var legs = $Sprite/Legs

func _physics_process(d):
	siner -= 1
	yoff = sin(siner/3)/2
	xoff = sin(siner/6)/2
	torso.position.x = 0 + xoff
	torso.position.y = -30 + (yoff / 1.5)
	head.position.x = 0 + xoff
	head.position.y = -56 + yoff
