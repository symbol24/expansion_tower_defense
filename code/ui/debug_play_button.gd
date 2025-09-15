extends Button


func _ready() -> void:
	pressed.connect(_pressed)


func _pressed() -> void:
	Signals.toggle_rid_control.emit(&"main_menu", &"main_menu", false)
	Signals.load_scene.emit(&"level", true, true)