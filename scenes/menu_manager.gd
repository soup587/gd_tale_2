extends Node2D

var current: Node

var prevmenus = []

var caninput := false

func set_menu(mnu: BattleMenu, args: Dictionary = {}):
	if current:
		current.active = false
		current.visible = false
		prevmenus.append(current)
	else:
		GlobalVars.battle.menustate = 1
		caninput = true
		get_parent().get_node("TextBox").visible = false
		get_parent().get_node("TextBox").typing = false
	if mnu.get_parent() != self:
		mnu.name = "menu"+str(prevmenus.size()+1)
		add_child(mnu)
	for k in args:
		mnu[k] = args[k]
	mnu.enable()
	await get_tree().process_frame
	current = mnu
	
func prev_menu():
	if prevmenus.size() == 0:
		get_parent().get_node("TextBox").visible = true
		get_parent().get_node("TextBox").trigger()
		GlobalVars.battle.menustate = 0
		%Buttons.change_sel(%Buttons.sel)
		clear()
	else:
		current.disable(true)
		current = prevmenus[prevmenus.size()-1]
		prevmenus.remove_at(prevmenus.size()-1)
		current.enable()
	
func clear():
	current.queue_free()
	current.active = false
	current = null
	for m in prevmenus:
		m.queue_free()
	prevmenus = []

func _unhandled_input(event: InputEvent) -> void:
	if not current: return
	if event.is_action_pressed("Cancel") and current.canreturn:
		prev_menu()
		
	if event.is_action_pressed("Confirm"):
		print(current)
		current.confirm()
