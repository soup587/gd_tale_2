extends Node2D

func _physics_process(delta: float) -> void:
	#var i = 0
	#for c: CollisionShape2D in $Collider.get_children():
	#	c.shape.a = $Lines.points[i]
	#	c.shape.b = $Lines.points[i+1 if i+1 < $Lines.points.size() else 0]
	#	i += 1
	
	$"Collider/1".shape.a = $Lines.points[0]
	$"Collider/1".shape.b = $Lines.points[1]
	$"Collider/2".shape.a = $Lines.points[1]
	$"Collider/2".shape.b = $Lines.points[2]
	$"Collider/3".shape.a = $Lines.points[2]
	$"Collider/3".shape.b = $Lines.points[3]
	$"Collider/4".shape.a = $Lines.points[3]
	$"Collider/4".shape.b = $Lines.points[0]
