extends Camera2D

var intensity: int = 0
var shaking: bool = false

func shake(i: int):
	intensity += i
	shaking = true

func _physics_process(delta: float) -> void:
	if !shaking: return
	var o = pow(-1, randi() % 2) * intensity
	offset.x = o/2
	offset.y = -o/2
	reset_physics_interpolation()
	intensity -= 1
	if intensity <= 0:
		shaking = false
		offset.x = 0
		offset.y = 0
