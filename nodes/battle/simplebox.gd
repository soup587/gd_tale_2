extends Node2D

@onready var top: StaticBody2D = $Top
@onready var bot: StaticBody2D = $Bottom
@onready var lft: StaticBody2D = $Left
@onready var rgt: StaticBody2D = $Right

signal finished

var size: Vector2i = Vector2i(570,136)
var tsize: Vector2i = Vector2i(570,136)

var updating: bool = false

var tsize5
var tsize2

var uf = true
var df = true
var lf = true
var rf = true

func set_size(ssize: Vector2i):
	tsize = ssize
	tsize5 = (tsize+Vector2i(5,5))/5
	tsize2 = tsize/2
	updating = true
	uf = false
	df = false
	rf = false
	lf = false

func _physics_process(d: float) -> void:
	if updating:
		if abs(tsize5.x - top.scale.x) <= 6:
			top.scale.x = tsize5.x
			uf = true
		elif top.scale.x > tsize5.x:
			top.scale.x -= 6
		elif top.scale.x < tsize5.x:
			top.scale.x += 6
		
		if abs(tsize5.x - bot.scale.x) <= 6:
			bot.scale.x = tsize5.x
			df = true
		elif bot.scale.x > tsize5.x:
			bot.scale.x -= 6
		elif bot.scale.x < tsize5.x:
			bot.scale.x += 6
			
		$BG.position.x = bot.scale.x*-2.5
		$BG.size.y = bot.position.y*2
		
		if abs(lft.position.x - -tsize2.x) <= 15:
			lft.position.x = -tsize2.x
			lf = true
		elif lft.position.x > -tsize2.x:
			lft.position.x -= 15
		else:
			lft.position.x += 15
		
		if abs(rgt.position.x - tsize2.x) <= 15:
			rgt.position.x = tsize2.x
			rf = true
		elif rgt.position.x > tsize2.x:
			rgt.position.x -= 15
		else:
			rgt.position.x += 15
		
		$BG.size.x = rgt.position.x*2
		$BG.position.y = rgt.scale.y*-2.5
		
		top.position.y = -tsize.y/2
		bot.position.y = tsize.y/2
		lft.scale.y = (tsize.y+5)/5
		rgt.scale.y = (tsize.y+5)/5
		
		if uf and df and lf and rf:
			updating = false
			finished.emit()
