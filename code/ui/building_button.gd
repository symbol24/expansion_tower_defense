class_name BuildingButton extends Control


const NORMAL := "bulding_button_normal"
const HOVER := "bulding_button_hover"


var data:BuildingData
var _mouse_over := false
var _build_position:Vector2

@onready var tile_map:TileMapLayer = %tile_map
@onready var over_panel:Panel = %over


func _ready() -> void:
	over_panel.mouse_entered.connect(_mouse_enter)
	over_panel.mouse_exited.connect(_mouse_exit)


func setup_button(new_data:BuildingData) -> void:
	if new_data != null:
		data = new_data.duplicate(true)
		tile_map.set_cell(Vector2i.ZERO, 0, data.coords)


func set_build_position(pos:Vector2) -> void:
	_build_position = pos


func click() -> void:
	Signals.build.emit(data, _build_position)
	Signals.close_build_menus.emit()


func _mouse_enter() -> void:
	_mouse_over = true
	over_panel.theme_type_variation = HOVER
	Signals.ui_area_entered.emit(self)


func _mouse_exit() -> void:
	_mouse_over = false
	over_panel.theme_type_variation = NORMAL
	Signals.ui_area_exited.emit(self)
