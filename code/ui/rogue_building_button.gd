class_name RogueBuildingButton extends Control


@onready var back: Panel = %back
@onready var over: Panel = %over
@onready var icon: TileMapLayer = %icon
@onready var mouse_detector: Control = %mouse_detector

var data:BuildingData

func _ready() -> void:
	mouse_detector.mouse_entered.connect(_mouse_enter)
	mouse_detector.mouse_exited.connect(_mouse_exit)


func setup_button(new_data:BuildingData) -> void:
	data = new_data
	icon.set_cell(Vector2.ZERO, 0, data.coords)


func _mouse_enter() -> void:
	over.show()


func _mouse_exit() -> void:
	over.hide()