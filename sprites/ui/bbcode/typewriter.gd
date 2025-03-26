class_name TextTypewriter
extends RichTextEffect

var bbcode = "type"

func play(audio: String) -> void:
	var audio_player := AudioStreamPlayer2D.new()
	audio_player.stream = load("res://snd/txt/" + audio + ".wav")
	Engine.get_main_loop().root.add_child(audio_player)
	audio_player.play()
	await audio_player.finished
	audio_player.queue_free()
	
var cnt = 0
func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var snd = char_fx.env.get("snd","txt1")
	var spd = char_fx.env.get("spd", 30)
	
	char_fx.visible = false	
	
	if char_fx.elapsed_time * spd >= char_fx.relative_index:
		char_fx.visible = true
		
	return true
