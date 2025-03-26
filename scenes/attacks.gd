extends Node2D

var valparses: Dictionary = {
	plrposx = (func():
		return GlobalVars.psoul.position.x
		),
	plrposy = (func():
		return GlobalVars.psoul.position.y
		)
}

func load_enemy_attack_file(path: String):
	var jsn = JSON.parse_string(FileAccess.get_file_as_string("res://data/attacks/"+path+".json"))
	if jsn.has("objects"):
		for obj in jsn.objects:
			var node = load("res://nodes/battle/attacks/"+obj.node+".tscn").instantiate()
		
			node.position.y = obj.position[1]
			if typeof(obj.position[0]) == TYPE_STRING:
				for k in valparses:
					if obj.position[0] == ("f_"+k):
						node.position.x = valparses[k].call()
						break
			else:
				node.position.x = obj.position[0]
					
			for k in obj.properties:
				if typeof(node[k]) == TYPE_VECTOR2:
					node[k] = Vector2(obj.properties[k][0], obj.properties[k][1])
				elif typeof(node[k]) == 6:
					node[k] = Vector2i(obj.properties[k][0], obj.properties[k][1])
				else:
					node[k] = obj.properties[k]
			add_child(node)
	$Timer.wait_time = jsn.length/30
	$Timer.start()
	
func _on_timer_timeout() -> void:
	GlobalVars.battle.do_playerturn()
