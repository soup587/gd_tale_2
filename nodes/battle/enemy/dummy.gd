extends Monster

func _ready():
	super._ready()
	
	acts.append(
		{
		"text": "Explode",
		"func": (func(): 
			GlobalVars.battle.texts.append("Unfortunately, the " + mname + " does not possess any explosives.") 
			GlobalVars.battle.do_texts(GlobalVars.battle.do_enemyturn)
			)
		}
	)
