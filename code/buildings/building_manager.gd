class_name BuildingManager extends Node2D


var _buildings:Array[Building] = []


func _ready() -> void:
	Signals.build.connect(_build)
	Signals.request_power.connect(_power_check)
	Signals.level_ready.connect(_power_check)
	_build(Data.TOWER_DATA.duplicate(), BuildMenuManager.SCREEN_START)


func _build(data:BuildingData, pos:Vector2) -> void:
	var building:Building = _get_building(data)
	building.name = data.id + "_0"
	add_child(building)
	building.setup_building(data)
	building.global_position = pos + Data.OFFSET
	Signals.building_added.emit(building)
	_power_check()


func _get_building(data:BuildingData) -> Building:
	for each in _buildings:
		if each.data.id == data.id:
			return each.duplicate()

	var new_building:Building = load(data.path).instantiate()
	new_building.data = data
	_buildings.append(new_building)
	return new_building.duplicate()


func _power_check() -> void:
	var power_dict:Dictionary = _get_power()
	Signals.send_power_dict.emit(power_dict)
	if power_dict[&"cost"] > power_dict[&"production"]:
		Signals.power_levels_to_low.emit()
	else:
		Signals.power_levels_good.emit()


func _get_power() -> Dictionary:
	var power_production := 0
	var power_cost := 0
	for each in _buildings:
		power_production += each.data.power_production
		power_cost += each.data.power_cost
	
	return {&"cost":power_cost, &"production":power_production}

