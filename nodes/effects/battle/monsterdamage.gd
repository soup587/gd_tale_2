extends Node2D

var maxhp := 100
var dishp := 100
var curhp := 100
var newhp := 100

var text := ""

var showbar := true

@onready var bar := $Control/Bar
@onready var num := $Control/Number

var done := false

signal finished

func _ready():
	if showbar:
		bar.max_value = maxhp
		bar.value = curhp
	else:
		bar.visible = false
		$Control/Panel.visible = false
	
	if !text:
		num.text = str(curhp - newhp)
		num.get_node("Anim").play("def")
	else:
		num.text = text
		num.set("theme_override_colors/font_color", Color(0.75,0.75,0.75))
		
	dishp = curhp
	
	if GlobalVars.battle:
		GlobalVars.battle.box.finished.connect(func():
			queue_free()
		)

func _physics_process(d):
	if done: return
	if dishp > newhp:
		dishp -= (curhp - newhp)/15
	else:
		dishp = newhp
		done = true
		finished.emit()
		
	bar.value = dishp
