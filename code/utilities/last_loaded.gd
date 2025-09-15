class_name LastLoaded extends Node


func _ready() -> void:
	Signals.level_ready.emit()