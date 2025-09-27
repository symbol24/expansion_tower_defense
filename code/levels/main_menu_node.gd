class_name MainMenuNode extends Node


func _ready() -> void:
	Signals.kill_node.connect(_kill_node)
	Signals.toggle_rid_control.emit(&"main_menu", &"", true)


func _kill_node(id:StringName) -> void:
	if id == &"main_menu":
		queue_free()