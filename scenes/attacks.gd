extends CanvasLayer

var iter = 0

var valparses: Dictionary = {
	plrposx = (func():
		return GlobalVars.psoul.position.x
		),
	plrposy = (func():
		return GlobalVars.psoul.position.y
		),
	iter = (func():
		return iter
		),
	brdbot = (func():
		return GlobalVars.psoul.position.x
		),
	brdtop = (func():
		return GlobalVars.psoul.position.y
		),
	brdlft = (func():
		return GlobalVars.psoul.position.x
		),
	brdrgt = (func():
		return GlobalVars.psoul.position.y
		)
}

var valwhens := {
	iter = true
}

func get_parser(val):
	if typeof(val) != TYPE_STRING:
		return false
	for k in valparses:
		if val.contains("f_"+k):
			return true

func parse_parser(val, trg = null):
	var t = typeof(val)
	if t == TYPE_STRING:
		for k in valparses:
			if val.contains("f_"+k):
				var e =  Expression.new()
				e.parse(val.replace(("f_"+k), str(valparses[k].call())))
				return e.execute()
	return val


func parse_val(val, trg = null):
	var tg = typeof(trg)
	if tg == TYPE_VECTOR2:
		return Vector2(parse_parser(val[0]), parse_parser(val[1]))
	elif tg == TYPE_VECTOR2I:
		return Vector2i(parse_parser(val[0]), parse_parser(val[1]))
	return parse_parser(val)
	
var lastvals = {}

func load_enemy_attack_file(path: String):
	var jsn = JSON.parse_string(FileAccess.get_file_as_string("res://data/attacks/"+path+".json"))
	lastvals = {}
	if jsn.has("objects"):
		iter = -1
		for obj in jsn.objects:
			for k in obj:
				lastvals[k] = obj[k]
			var loops = 1
			if lastvals.has("count"):
				loops = lastvals.count
			for i in loops:
				iter += 1
				var node = load("res://nodes/battle/attacks/"+(lastvals.node)+".tscn").instantiate()
				
				if get_parser(lastvals.position[0]):
					node.position = parse_val(lastvals.position, node.position)
				else:
					node.changed_enabled.connect(func():
						node.position.x = parse_val(lastvals.position[0])
						node.position.y = parse_val(lastvals.position[1])
					)

				if lastvals.has("delay"):
					node.delay = lastvals.delay
				if lastvals.has("countdelay"):
					node.delay += (lastvals.countdelay*i)
				
				if obj.has("properties"):
					for k in obj.properties:
						node[k] = parse_val(obj.properties[k], node[k])
						node.changed_enabled.connect(func():
							node[k] = parse_val(obj.properties[k], node[k])
						)
				add_child(node)
	GlobalVars.battle.box.set_size(Vector2i(parse_val(jsn.boxsize[0]),parse_val(jsn.boxsize[1])))
	$Timer.wait_time = jsn.length/30
	$Timer.start()
	
func _on_timer_timeout() -> void:
	GlobalVars.battle.do_playerturn()
	GlobalVars.battle.box.set_size(Vector2i(570,136))
