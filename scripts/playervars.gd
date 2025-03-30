extends Node
var health = 20
var maxhealth = 20

var df = 0
var at = 10

var inv = 0
var maxinv = 30

var spd = 0
var maxspd = 4

var attackspd = 11
var attackspeedr = 2

signal plrdamage

func damage_player(amt = 1, iinv = true):
	if iinv:
		if inv > 0:
			return
	health = health - amt
	inv = maxinv
	plrdamage.emit()

func _input(event):
	if event.is_action_pressed("Space"):
		GlobalVars.battle.do_playerturn()

func _physics_process(d):
	inv -= 1
