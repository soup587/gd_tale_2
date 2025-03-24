extends Node2D

var siner = 0
var xoff = 0
var yoff = 0

func _physics_process(d):
	siner -= 1
	yoff = sin(siner/3)/2
	xoff = sin(siner/6)/2
	$Torso.position.x = 0 + xoff
	$Torso.position.y = -30 + (yoff / 1.5)
	$Head.position.x = 0 + xoff
	$Head.position.y = -56 + yoff
