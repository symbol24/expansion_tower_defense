class_name MainMenuNode extends Node


func _ready() -> void:
	Signals.toggle_rid_control.emit(&"main_menu", &"", true)