class_name BootIntros extends RidControl


@onready var anim: AnimationPlayer = %anim

var _current := &""
var _sent := false


func _input(_event: InputEvent) -> void:
	if not _sent and Input.is_anything_pressed():
		_play_anim(&"RESET")


func _ready() -> void:
	anim.animation_finished.connect(_play_anim)
	await get_tree().create_timer(0.5).timeout
	_play_anim()


func _play_anim(_anim := &"") -> void:
	anim.stop()
	match _current:
		&"":
			_current = &"wild_jam"
			anim.play(_current)
		&"wild_jam":
			_current = &"godot"
			anim.play(_current)
		&"godot":
			_current = &"rid"
			anim.play(_current)
		&"rid":
			if not _sent:
				Signals.load_scene.emit(&"main_menu", false, false)
				Signals.toggle_rid_control.emit(id, id, false)
				_sent = true
		_:
			pass