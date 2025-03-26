extends Node2D

func _physics_process(delta: float) -> void:
	var i = 0
	for c: CollisionShape2D in $Collider.get_children():
		c.shape.a = $Lines.points[i]
		c.shape.b = $Lines.points[i+1 if i+1 < $Lines.points.size() else 0]
		i += 1
