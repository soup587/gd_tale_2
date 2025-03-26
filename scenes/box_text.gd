extends Control

@export var snd = "txt1"
@export var skippable = true

@onready var tx = $Text

func play(audio: String) -> void:
	var audio_player = $sound
	audio_player.stream = load("res://snd/txt/" + audio + ".wav")
	audio_player.play()

var typing = false
var skipped = false

func trigger():
	tx.visible_characters = 0
	typing = true
	skipped = false
	
var line = 0

func _physics_process(delta):
	if not typing: return
	if tx.visible_characters >= tx.get_parsed_text().length():
		typing = false
		return
	tx.visible_characters += 1
	var ptext = tx.get_parsed_text()
	if ptext.unicode_at(tx.visible_characters) != 32:	
		play(snd)
	if ptext.unicode_at(tx.visible_characters-1) == 44:
		typing = false
		await get_tree().create_timer(0.25).timeout
		if not skipped: typing = true
	
func _ready():
	trigger()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Cancel") and skippable:
		tx.visible_characters = -1
		typing = false
		skipped = true
