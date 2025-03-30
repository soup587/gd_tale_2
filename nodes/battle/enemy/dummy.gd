extends Monster

func _ready():
	super()
	
	acts.append(
		{
		"text": "Explode",
		"func": (func(): 
			GlobalVars.battle.texts.append("Unfortunately, the " + mname + " does not possess any explosives.") 
			GlobalVars.battle.do_texts(GlobalVars.battle.do_enemyturn)
			)
		}
	)
	
	shudder_finshed.connect(func():
		csprite.get_node("Sprite").animation = "default"
	)

func _on_hit():
	super()
	csprite.get_node("Sprite").animation = "hurt"
