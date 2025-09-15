class_name Boot extends Node


func _ready() -> void:
	Signals.toggle_rid_control.emit(&"boot_intros", &"", true)
	queue_free()