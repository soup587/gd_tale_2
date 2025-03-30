class_name AudioPlayer

static func _create(audio: AudioStream) -> AudioStreamPlayer:
	var audio_player := AudioStreamPlayer.new()
	audio_player.stream = audio
	Engine.get_main_loop().root.add_child(audio_player)
	return audio_player
	
static func _ply(player: AudioStreamPlayer, vol, pitch):
	player.volume_linear = vol
	player.pitch_scale = pitch
	player.play()
	await player.finished
	player.queue_free()

static func play(audio: AudioStream, vol: float = 1, pitch: float = 1) -> void:
	_ply(_create(audio), vol, pitch)

static func play_sel():
	var plr = _create(load("res://snd/select.wav"))
	plr.bus = "SFX"
	_ply(plr,1.1,1)
