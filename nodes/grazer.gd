extends Area2D

var timer := 0

var tpfactor := 1
var timefactor := 1
var sizefactor := 1

@onready var sprite1 := $Sprite1
@onready var sprite2 := $Sprite2

func _ready() -> void:
	sprite1.modulate.a = (timer/6)
	sprite2.modulate.a = (timer/6 - 0.2)

func _on_area_entered(area: Area2D) -> void:
	pass

func _physics_process(d):
	for n in get_overlapping_areas():
		var bl = n.get_parent()
		if !bl.enabled: return
		if !n.monitoring: return
		if PlayerVars.inv > 0: return
		if bl.grazed:
			if (timer >= 0 and timer < 4):
				timer = 3
			elif (timer < 2):
				timer = 2
		else:
			bl.grazed = true
			MgrTension.add(bl.gpoints)
			$snd.play()
			timer = 10
	
	if timer > 0:
		sprite1.modulate.a = (timer/6.0)
		sprite2.modulate.a = (timer/6.0 - 0.2)
	else:
		sprite1.modulate.a = 0
		sprite2.modulate.a = 0
	timer -= 1
