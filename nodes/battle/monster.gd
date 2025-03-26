@tool
@icon("res://editor/msoul.svg")
class_name Monster
extends Node2D

@export var mname = ""
@export var maxhealth = 100
var health = maxhealth

@export var at = 0
@export var df = 0

@export var attacks: Array = ["default"]

@export var sprite: PackedScene:
	set(new):
		var n = new.instantiate()
		add_child(n)
		
		sprite = new
		
		
var acts = [
	{
		"text": "Check",
		"func": (func(): 
			GlobalVars.battle.texts.append(mname+" - ATK "+str(at)+" DEF "+str(df)) 
			GlobalVars.battle.do_texts(GlobalVars.battle.do_playerturn)
			)
	}
]

var flavors = []

func _ready():
	flavors = 	[
	(mname+" is clueless."),
	(mname+" probably has better things to be doing."),
	(mname+" remembers you're genocides."),
	(mname+" looks like it's going to fall over.")
	]
	GlobalVars.battle.playerturn.connect(func():
		GlobalVars.battle.flavortext = flavors.pick_random()
	)
	
	GlobalVars.battle.enemy_turn.connect(func():
		GlobalVars.battle.cattack = attacks.pick_random()
	)
