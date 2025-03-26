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

func set_sel(st):
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
		AudioPlayer.play_sel()
		match type:
			0:
				pass
			1:
				var mnus = load("res://nodes/battle/menu/entries.tscn")
				var mnu = mnus.instantiate()
				for m in GlobalVars.battle.monsters:
					var smnu = mnus.instantiate()
					mnu.add_entry(m.name, func(): GlobalVars.battle.menumanager.set_menu(smnu))
					for a in m.acts:
						smnu.add_entry(a.text, a.func)
				GlobalVars.battle.menumanager.set_menu(mnu)
			2:
				pass
			3:
				pass
