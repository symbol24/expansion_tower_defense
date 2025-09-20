class_name BuildingData extends Resource


@export var id := &""
@export var description := ""
@export var coords:Vector2i
@export var path:String
@export var tick_building := false
@export var can_low_power := true

@export_category("Costs")
@export var money_cost := 1
@export var power_cost := 0
@export var material_cost := 1

@export_category("Production")
@export var money_production := 0
@export var power_production := 0
@export var material_production := 0

@export_category("Life Stats")
@export var starting_hp := 100
var current_level := 1
var current_hp := 100.0
var max_hp := 100.0
var is_active := false


func setup_building_data() -> void:
	current_hp = starting_hp
	max_hp = starting_hp


func update_hp(value:=0) -> void:
	current_hp += value
	if current_hp <= 0:
		pass
	elif current_hp >= max_hp:
		current_hp = max_hp


func get_money_production() -> int:
	if not is_active: return 0
	return money_production


func get_materials_production() -> int:
	if not is_active: return 0
	return material_production

