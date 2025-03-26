class_name BattleMenuEntried
extends BattleMenu

var entryScene = preload("res://nodes/battle/menu/entry.tscn")

var list: Array

var idx = 0

var active = true

func add_entry(nam: String, fnc: Callable):
	var etry = entryScene.instantiate()
	etry.name = "Entry" + str(list.size())
	etry.position = Vector2(-290 + (260 * list.size()),-47)
	etry.txt = "* " + nam
	etry.fnc = fnc
	
	add_child(etry)
	if list.size() < 1:
		etry.set_sel()
	list.append(etry)

func confirm():
	list[idx].interact()
	AudioPlayer.play_sel()
	
func change_sel(i):
	if not (i >= 0 and i < list.size()): return
	list[idx].sel = false
	list[i].set_sel()
	idx = i
	
func enable():
	change_sel(idx)
	visible = true
	active = true
	
func disable(harsh: bool = false):
	active = false
	visible = false
	if harsh:
		change_sel(0)

func _input(event: InputEvent) -> void:
	if not active: return
	if event.is_action_pressed("Right"):
		change_sel(idx + 1)
	if event.is_action_pressed("Left"):
		change_sel(idx - 1)
