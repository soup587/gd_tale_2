extends Node2D

@onready var butts = get_children()

var sel = 0

func _ready():
	pass

func change_sel(i):
	if i < butts.size() and i >= 0:
		GlobalVars.psoul.position = butts[i].position - Vector2(38,0)
		GlobalVars.psoul.reset_physics_interpolation()
		butts[sel].set_sel(false)
		butts[i].set_sel(true)
		sel = i

func _battle_init():
	change_sel(0)

func _input(evt):
	if GlobalVars.battle.menustate == 0:
		if evt.is_action_pressed("Right"):
			change_sel(sel + 1)
		if evt.is_action_pressed("Left"):
			change_sel(sel - 1)
