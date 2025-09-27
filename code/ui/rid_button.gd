class_name RidButton extends Button


@export var destination:StringName


func _ready() -> void:
	pressed.connect(_pressed)


func _pressed() -> void:
	Signals.button_handling.emit(destination)