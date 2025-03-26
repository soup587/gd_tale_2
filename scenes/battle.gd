extends Node2D

var menustate = 0
var currentmenuid
var currentmenu: Node

var monsters = []

@onready var menumanager = $Box/MenuManager

func _init():
	PlayerVars.spd = PlayerVars.maxspd
	GlobalVars.battle = self
	
signal battle_init

var flavortext = "???"

func _ready():
	GlobalVars.psoul = load("res://nodes/soul.tscn").instantiate()
	add_child(GlobalVars.psoul)
	for m in $Monsters.get_children():
		monsters.append(m)
	battle_init.emit()
	do_playerturn()
	
var texts: Array
var texti = 0
var texting = false

var textcall: Callable

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Confirm"):
		if texting and not $Box/TextBox.typing:
			_do_texti()

func _do_texti():
	if texti == texts.size():
		texting = false
		texti = 0
		textcall.call()
		return
	$Box/TextBox/Text.text = texts[texti]
	$Box/TextBox.trigger()
	texti += 1

func do_texts(callback: Callable):
	textcall = callback
	$Buttons.butts[$Buttons.sel].set_sel(false)
	$Box/TextBox.visible = true
	texting = true
	menumanager.clear()
	GlobalVars.psoul.visible = false
	
signal enemy_turn
signal enemy_turn_over

var cattack: String = "default"
	
func do_enemyturn():
	enemy_turn.emit()
	$Box/TextBox.visible = false
	$Box/TextBox.typing = false
	$Buttons.butts[$Buttons.sel].set_sel(false)
	GlobalVars.psoul.visible = true
	GlobalVars.psoul.position = $Box.position
	GlobalVars.psoul.reset_physics_interpolation()
	GlobalVars.psoul.control = true
	texts = []
	menustate = -1
	$Attacks.load_enemy_attack_file(cattack)

signal playerturn

func do_playerturn():
	enemy_turn_over.emit()
	playerturn.emit()
	$Box/TextBox/Text.text = flavortext
	$Box/TextBox.visible = true
	$Box/TextBox.trigger()
	$Buttons.change_sel($Buttons.sel)
	GlobalVars.psoul.visible = true
	GlobalVars.psoul.reset_physics_interpolation()
	GlobalVars.psoul.control = false
	texts = []
	menustate = 0
