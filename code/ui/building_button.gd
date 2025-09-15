class_name BuildingButton extends Control


const NORMAL := "bulding_button_normal"
const HOVER := "bulding_button_hover"


var data:BuildingData
var _mouse_over := false
var _build_position:Vector2

@onready var tile_map:TileMapLayer = %tile_map
@onready var over_panel:Panel = %over
@onready var power: Label = %power
@onready var materials: Label = %materials
@onready var money: Label = %money


func _ready() -> void:
	over_panel.mouse_entered.connect(_mouse_enter)
	over_panel.mouse_exited.connect(_mouse_exit)
	Signals.building_purchase_result.connect(_treat_purchase_result)


func setup_button(new_data:BuildingData) -> void:
	if new_data != null:
		data = new_data.duplicate(true)
		tile_map.set_cell(Vector2i.ZERO, 0, data.coords)
		money.text = str(data.money_cost)
		materials.text = str(data.material_cost)
		power.text = str(data.power_cost)


func set_build_position(pos:Vector2) -> void:
	_build_position = pos


func click() -> void:
	Signals.build_request.emit(data)


func _treat_purchase_result(building_data:BuildingData, result:bool) -> void:
	if data != building_data: return
	if result:
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
