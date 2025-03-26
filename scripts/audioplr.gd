class_name AudioPlayer

static func _create(audio: AudioStream) -> AudioStreamPlayer:
	var audio_player := AudioStreamPlayer.new()
	audio_player.stream = audio
	Engine.get_main_loop().root.add_child(audio_player)
	return audio_player
	
static func _ply(player: AudioStreamPlayer):
	player.play()
	await player.finished
	player.queue_free()

static func play(audio: AudioStream) -> void:
	_ply(_create(audio))

static func play_sel():
	var plr = _create(load("res://snd/select.wav"))
	plr.bus = "SFX"
	plr.volume_linear = 1.1
	_ply(plr)
