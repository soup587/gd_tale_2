extends Node2D

var menustate = 0
var currentmenu

func _init():
	PlayerVars.spd = PlayerVars.maxspd
	GlobalVars.battle = self
	
signal battle_init

func _ready():
	GlobalVars.psoul = load("res://nodes/soul.tscn").instantiate()
	add_child(GlobalVars.psoul)
	battle_init.emit()

func set_menu(mnu: PackedScene):
	$Box/BoxText.visible = false
	var mnui = mnu.instantiate()
	mnui.name = "Menu"
	mnui.add_entry("* Check",
	func():
		texts.append("* He does stuff")
		texts.append("* Yeah")
		do_texts()
	)
	mnui.position = Vector2(-$Box.position.x,-50)
	$Box.add_child(mnui)
	currentmenu = mnui.id
	menustate = 1
	
func clear_menu():
	$Box/Menu.queue_free()
	
var texts: Array
var texti = 0
var texting = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Confirm"):
		if texting:
			_do_texti()

func _do_texti():
	if texti == texts.size():
		texting = false
		texti = 0
		return
	$Box/BoxText.text = texts[texti]
	texti += 1

func do_texts():
	clear_menu()
	$Box/BoxText.visible = true
	texting = true
	GlobalVars.psoul.visible = false
