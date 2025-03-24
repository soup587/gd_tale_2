extends Node
var health = 20
var maxhealth = 20

var inv = 0
var maxinv = 30

var spd = 0
var maxspd = 4

signal plrdamage

func damagePlayer(amt = 1, iinv = true):
	if iinv:
		if inv > 0:
			return
	health = health - amt
	inv = maxinv
	plrdamage.emit()

func _input(event):
	pass
	#if event.is_action_pressed("Space"):
	#	damagePlayer(1)

func _physics_process(d):
	if Input.is_action_pressed("Space"):
		damagePlayer(1,false)
	inv -= 1
