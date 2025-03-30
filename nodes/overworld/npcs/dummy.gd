extends Interactable

func _on_interact():
	Encounters.start_encounter("test")
