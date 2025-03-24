class_name BattleMenuEntried
extends BattleMenu

var entryScene = preload("res://nodes/battle/menu/entry.tscn")

var list: Array

func add_entry(nam: String, fnc: Callable):
	var etry = entryScene.instantiate()
	etry.txt = nam
	etry.fnc = fnc
	
	add_child(etry)
	if list.size() < 1:
		etry.set_sel()
	list.append(etry)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Cancel"):
		GlobalVars.battle.menustate = 0
		queue_free()
	if event.is_action_pressed("Confirm"):
		list[0].interact()
