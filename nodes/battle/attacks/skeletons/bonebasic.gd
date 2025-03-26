@tool
extends BasicVelocityAttack

@export_enum("Sans", "Papyrus") var type: int
@export var height: int:
	set(new):
		height = new
		if Engine.is_editor_hint():
			_update_shape()

func _update_shape():
	$Sprite/Top.position.y = -height - 9
	$Sprite/Middle.scale.y = height
	$Collision/Shape.shape.size.y = height + 4
	$Collision/Shape.position.y = -height/2 - 6
	
func _ready():
	_update_shape()
	super()
