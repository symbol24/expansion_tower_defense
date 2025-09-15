class_name BootIntros extends RidControl


func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	Signals.load_scene.emit(&"main_menu", false, false)
	Signals.toggle_rid_control.emit(id, id, false)