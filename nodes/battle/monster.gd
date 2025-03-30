@tool
@icon("res://editor/msoul.svg")
class_name Monster
extends Node2D

@export var mname = ""
@export var maxhealth = 100
var health = maxhealth

var damages = preload("res://nodes/effects/battle/monsterdamage.tscn")

@export var at = 0
@export var df = 0

@export var attacks: Array = ["default"]

var slashpos

@export var sprite: PackedScene:
	set(new):
		var n = new.instantiate()
		add_child(n)
		slashpos = n.get_node("SlashPos")
		csprite = n
		sprite = new
	
var csprite: Node2D

@export var fallbacksprite: Image
		
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

func spawn_dmgwriter():
	var ds = damages.instantiate()
	ds.maxhp = maxhealth
	ds.curhp = health
	ds.newhp = health - GlobalVars.battle.monsterdmg
	ds.position = slashpos.global_position + Vector2(0,-60)
	GlobalVars.battle.add_child(ds)
	return ds
	
func spawn_dmgwriter_txt(txt: String):
	var ds = damages.instantiate()
	ds.position = slashpos.global_position + Vector2(0,-60)
	ds.text = txt
	ds.showbar = false
	GlobalVars.battle.add_child(ds)

func _on_attacked():
	pass
	
var shudder := 0
var shuddering := false
var sha := 0.0

signal shudder_finshed

func do_shudder(val):
	shudder = val
	sha = position.x
	shuddering = true
	
func _shuddering():
	if shudder < 0:
		shudder = -(shudder + 1)
	else:
		shudder = -shudder
	csprite.position.x = sha + shudder
	csprite.reset_physics_interpolation()
	if shudder == 0:
		shudder_finshed.emit()
		shuddering = false
		csprite.position.x = sha 

func _physics_process(delta: float) -> void:
	if shuddering:
		_shuddering()

func _on_hit():
	var d = spawn_dmgwriter()
	health -= GlobalVars.battle.monsterdmg
	do_shudder(8)
	await shudder_finshed
	GlobalVars.battle.do_enemyturn()

func _ready():
	flavors = 	[
	(mname+" is clueless."),
	(mname+" probably has better things to be doing."),
	(mname+" remembers you're genocides."),
	(mname+" looks like it's going to fall over.")
	]
	
	GlobalVars.battle.enemy_turn.connect(func():
		GlobalVars.battle.cattack = attacks.pick_random()
	)
	
	GlobalVars.battle.monster_attacked.connect(func():
		if GlobalVars.battle.targetmonster == self:
			_on_attacked()
	)
	
	GlobalVars.battle.monster_hit.connect(func():
		if GlobalVars.battle.targetmonster == self:
			_on_hit()
	)
