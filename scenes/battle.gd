extends Node2D

var menustate = 0
var currentmenuid
var currentmenu: Node

var monsters = []
var targetmonster
var monsterdmg := 0

@onready var box = $UI/Box
@onready var menumanager = $UI/Box/MenuManager

var soulsc = preload("res://nodes/soul.tscn")

func _init():
	PlayerVars.spd = PlayerVars.maxspd
	GlobalVars.battle = self
	
signal battle_init

var flavortext: String

func _ready():
	GlobalVars.psoul = soulsc.instantiate()
	$Soul.add_child(GlobalVars.psoul)
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
		if texting and not $UI/Box/TextBox.typing:
			_do_texti()
			
signal monster_attacked
signal monster_hit

func _do_texti():
	if texti == texts.size():
		texting = false
		texti = 0
		textcall.call()
		return
	$UI/Box/TextBox/Text.text = texts[texti]
	$UI/Box/TextBox.trigger()
	texti += 1

func do_texts(callback: Callable):
	textcall = callback
	$UI/Buttons.butts[$UI/Buttons.sel].set_sel(false)
	$UI/Box/TextBox.visible = true
	texting = true
	menumanager.clear()
	GlobalVars.psoul.visible = false

var is_enemy_turn: bool = false

signal enemy_turn
signal enemy_turn_over
var monsterturns: int = 0

var cattack: String = "default"
	
func do_enemyturn():
	enemy_turn.emit()
	is_enemy_turn = true
	if $UI/Box/MenuManager/menu2:
		$UI/Box/MenuManager/menu2.remove()
		
	$UI/Box/TextBox.visible = false
	$UI/Box/TextBox.typing = false
	$UI/Buttons.butts[$UI/Buttons.sel].set_sel(false)
	GlobalVars.psoul.visible = true
	GlobalVars.psoul.position = $UI/Box.position
	GlobalVars.psoul.reset_physics_interpolation()
	GlobalVars.psoul.control = true
	texts = []
	menustate = -1
	$Attacks.load_enemy_attack_file(cattack)

signal playerturn
var playerturns: int = 0

func do_playerturn():
	var was_enemy_turn = is_enemy_turn
	is_enemy_turn = false
	enemy_turn_over.emit()
	if was_enemy_turn:
		GlobalVars.psoul.visible = false
		await box.finished
	playerturn.emit()
	playerturns += 1
	if flavortext:
		$UI/Box/TextBox/Text.text = flavortext
	else:
		$UI/Box/TextBox/Text.text = monsters.pick_random().flavors.pick_random()
	$UI/Box/TextBox.visible = true
	$UI/Box/TextBox.trigger()
	$UI/Buttons.change_sel($UI/Buttons.sel)
	GlobalVars.psoul.visible = true
	GlobalVars.psoul.reset_physics_interpolation()
	GlobalVars.psoul.control = false
	texts = []
	menustate = 0
