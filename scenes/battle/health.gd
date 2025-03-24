extends Node2D

func _physics_process(delta):
	$HPText.text = "%02d / %02d" % [PlayerVars.health, PlayerVars.maxhealth]
	$HPBar.size.x = (PlayerVars.maxhealth*1.2)+1
	$HPBar/FG.size.x = (PlayerVars.health*1.2)+1
