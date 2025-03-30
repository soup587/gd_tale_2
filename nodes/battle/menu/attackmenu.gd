extends BattleMenu

@onready var target = $Target
@onready var selector = $Selector

var speed = 0

var fail: bool = false

var fading: bool = false

var monster: Monster

var attacking: bool = false

func _ready() -> void:
	GlobalVars.battle.menumanager.clear()
	GlobalVars.psoul.visible = false
	if selector.position.x < position.x:
		speed = (PlayerVars.attackspd + randf_range(0,PlayerVars.attackspeedr))
	elif selector.position.x > position.x:
		speed = -(PlayerVars.attackspd + randf_range(0,PlayerVars.attackspeedr))

func attack_calc(monster: Monster):
	return PlayerVars.at - monster.df

func confirm():
	if attacking: return
	attacking = true
	selector.play()
	speed = 0
	
	GlobalVars.battle.targetmonster = monster
	
	var damage = attack_calc(monster) + randi_range(0,2)
	
	var bonus = abs(selector.position.x - position.x)
	if bonus == 0: bonus = 1
	var stretch = (target.texture.get_width() - bonus) / target.texture.get_width()
	
	if bonus <= 12:
		damage = round(damage * 2.2)
	if bonus > 12:
		damage = round(damage * stretch * 2)
	
	GlobalVars.battle.monsterdmg = damage
	
	var slice = load("res://nodes/effects/slice.tscn").instantiate()
	slice.global_position = monster.slashpos.global_position
	slice.scale.x = 1.5
	slice.scale.y = 1.5
	
	GlobalVars.battle.add_child(slice)
	GlobalVars.battle.monster_attacked.emit()

func remove():
	fading = true
	selector.queue_free()

func _physics_process(delta: float) -> void:
	if fading:
		modulate.a -= 0.08
		scale.x -= 0.06
		
		if scale.x < 0.08:
			queue_free()
		return
	
	selector.position.x += speed
	
	if speed > 0 and selector.position.x > 273:
		fail = true
	if speed < 0 and selector.position.x < 273:
		fail = true
	if fail:
		remove()
