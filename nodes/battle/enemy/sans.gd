extends Monster

func _on_hit():
	spawn_dmgwriter_txt("MISS")
	GlobalVars.battle.do_enemyturn()

func _on_attacked():
	csprite.get_node("Anims").play("dodge")

func _ready():
	super()
	PlayerVars.maxinv = 0
	flavors = [
		"You felt your sins crawling on your back."
	]
