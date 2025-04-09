extends Node

var battlescene = preload("res://scenes/battle.tscn")

var prevscene: Object

var currencounter

func _start_encounter(path):
	var fl = JSON.parse_string(FileAccess.get_file_as_string("res://data/encounters/"+path+".json"))
	var tree = get_tree()
	prevscene = tree.get_current_scene()
	if prevscene.has_method("deinst"):
		prevscene.deinst()
	get_tree().root.remove_child(prevscene)
	var battle = battlescene.instantiate()
	var monsternode = battle.get_node("Monsters")
	var i = 1
	for m in fl.monsters:
		var mi = load("res://nodes/battle/enemy/"+m+".tscn").instantiate()
		mi.z_index = fl.monsters.size() - i
		mi.position.x = ((i-1)*(300/fl.monsters.size())) * (-1 if i % 2 == 0 else 2)
		mi.name = mi.mname + " " + String.chr('@'.unicode_at(0)+i)
		monsternode.add_child(mi)
		i += 1
	if fl.has("bgm"):
		battle.get_node("BGM").stream = load("res://mus/"+fl.bgm+".ogg")
	get_tree().root.add_child(battle)
	
func start_encounter(path = null, fast := 0):
	if path:
		currencounter = path
	if fast == 0:
		if GlobalVars.ovrwrld:
			GlobalVars.ovrwrld.add_child(preload("res://nodes/effects/overworld/battleblcon.tscn").instantiate())
		else:
			_start_encounter(path)
	else:
		_start_encounter(currencounter)
	


func end_encounter():
	var tree = get_tree()
	get_tree().root.remove_child(GlobalVars.battle)
	if prevscene.has_method("reinst"):
		prevscene.reinst()
	get_tree().root.add_child(prevscene)
	tree.set_current_scene(prevscene)
