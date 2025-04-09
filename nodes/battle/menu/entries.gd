class_name BattleMenuEntried
extends BattleMenu

var entryScene = preload("res://nodes/battle/menu/entry.tscn")

var list: Array
var pages: Array

var idx = 0
var pidx = 0
var ppidx = 0

var active = true
func add_entry(nam: String, fnc: Callable):
	var lsize = list.size()
	var etry = entryScene.instantiate()
	etry.name = "Entry" + str(lsize)
	etry.position = Vector2(-290 + (260 * wrap(lsize,0,2)),-47 + (-34 * (wrap(lsize,0,4)/-2)))
	etry.txt = "* " + nam
	etry.fnc = fnc
	
	var pgn = (lsize / 4)
	if !pages.has(pgn):
		pages.append([])
		var pnode = Node2D.new()
		pnode.name = "Page" + str(pgn)
		if pgn >= 1:
			pnode.visible = false
		add_child(pnode)
	pages[pgn].append(etry)
	get_node("Page" + str(pgn)).add_child(etry)

	if lsize < 1:
		etry.set_sel()
	list.append(etry)

func confirm():
	list[idx].interact()
	AudioPlayer.play_sel()

func _update_page():
	get_node("Page" + str(ppidx)).visible = false
	get_node("Page" + str(pidx)).visible = true
	ppidx = pidx
	$PageText.text = "PAGE " + str(pidx + 1) + "/" + str(pages.size()/3)

func change_sel(i):
	if not (i >= 0 and i < list.size()): return
	list[idx].sel = false
	
	if (i / 4) != pidx:
		pidx = (i/4)
		_update_page()
	
	list[i].set_sel()
	idx = i
	
func enable():
	change_sel(idx)
	visible = true
	active = true
	if list.size() > 4:
		$PageText.visible = true
		_update_page()
	
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
	if event.is_action_pressed("Up"):
		change_sel(idx - 2)
	if event.is_action_pressed("Down"):
		change_sel(idx + 2)
