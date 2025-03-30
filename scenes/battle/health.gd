extends Node2D

func update():
	$HPText.text = "%02d / %02d" % [PlayerVars.health, PlayerVars.maxhealth]
	#$HPBar.size.x = (PlayerVars.maxhealth*1.2)+1
	#$HPBar/FG.size.x = (PlayerVars.health*1.2)+1
	$HPBar/Bar.max_value = PlayerVars.maxhealth
	$HPBar/Bar.value = PlayerVars.health

func _ready():
	update()

func _physics_process(delta):
	update()
