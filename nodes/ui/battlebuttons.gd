@tool
extends Node2D

@export_enum("Fight", "Act", "Item", "Mercy") var type: int:
	set(new):
		var sprite
		match new:
			0:
				sprite = load("res://sprites/ui/fight.png")
			1:
				sprite = load("res://sprites/ui/act.png")
			2:
				sprite = load("res://sprites/ui/item.png")
			3:
				sprite = load("res://sprites/ui/mercy.png")
		$Sprite.texture = sprite
		type = new
		
var state = false

func setSel(st):
	if st == state: return
	$Sprite.frame = st and 1 or 0
	if st: $snd_movemenu.play()
	state = st

func _on_area_2d_body_entered(body):
	#setSel(true)
	pass

func _on_area_2d_body_exited(body):
	#setSel(false)
	pass

func _on_interact():
	if GlobalVars.battle:
		GlobalVars.battle.set_menu(load("res://nodes/battle/menu/entries.tscn"))
