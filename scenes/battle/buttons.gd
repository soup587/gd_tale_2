extends Node2D

@onready var butts = get_children()

var sel

func _ready():
	pass

func changeSel(i):
	if i < butts.size() and i >= 0:
		GlobalVars.psoul.position = butts[i].position - Vector2(38,0)
		GlobalVars.psoul.reset_physics_interpolation()
		butts[i].setSel(true)
		if not sel == null:
			butts[sel].setSel(false)
		sel = i

func _battle_init():
	changeSel(0)

func _input(evt):
	if GlobalVars.battle.menustate == 0:
		if evt.is_action_pressed("Right"):
			changeSel(sel + 1)
		if evt.is_action_pressed("Left"):
			changeSel(sel - 1)
