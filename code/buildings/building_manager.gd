class_name BuildingManager extends Node2D


var _first_spawn_point := Vector2(Data.SCREEN_START) - Data.OFFSET
var _buildings:Array[Building] = []


func _ready() -> void:
	Signals.build.connect(_build)
	Signals.request_power.connect(_power_check)
	Signals.level_ready.connect(_power_check)
	Signals.remove_building.connect(_remove_building)
	Signals.check_death_for_resources.connect(_check_for_resources)
	_build_tower()


func _build_tower() -> void:
	match Gm.get_gamemode():
		BuildingData.Building_Type.PLACEMENT:
			_build(Data.PLACEMENT_TOWER_DATA.duplicate(), _first_spawn_point)
		_:
			_build(Data.TOWER_DATA.duplicate(), _first_spawn_point)


func _build(data:BuildingData, pos:Vector2) -> void:
	var building:Building = load(data.path).instantiate()
	building.name = data.id + "_0"
	add_child(building)
	building.setup_building(data)
	building.global_position = pos + Data.OFFSET
	_buildings.append(building)
	Signals.building_added.emit(building)
	_power_check()


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


func _remove_building(building:Building) -> void:
	_buildings.remove_at(_buildings.find(building))
	remove_child.call_deferred(building)
	building.queue_free.call_deferred()


func _check_for_resources(pos:Vector2) -> void:
	if Gm.get_gamemode() != BuildingData.Building_Type.TICK:
		var money_chance := _get_chance_of_money()
		var money_over := money_chance - 1.0 if money_chance > 1.0 else 0.0
		var money := 0
		var materials_chance := _get_chance_of_materials()
		var materals_over := materials_chance - 1.0 if materials_chance > 1.0 else 0.0
		var materials := 0

		if randf() <= money_chance:
			money = randi_range(1, _get_money_total(money_over))
			Signals.spawn_resource_floater.emit(&"coin", pos)
		
		if randf() <= materials_chance:
			materials = randi_range(1, _get_material_total(materals_over))
			Signals.spawn_resource_floater.emit(&"material", pos)

		Signals.add_resources_dict.emit({&"coins":money, &"materials":materials})


func _get_chance_of_money() -> float:
	var result := 0.0
	for each in _buildings:
		result += each.data.money_chance
	return result


func _get_money_total(over:float) -> int:
	var result := 0
	for each in _buildings:
		result += each.data.money_production
	if randf() <= over: result += 1
	return result


func _get_chance_of_materials() -> float:
	var result := 0.0
	for each in _buildings:
		result += each.data.material_chance
	return result


func _get_material_total(over:float) -> int:
	var result := 0
	for each in _buildings:
		result += each.data.material_production
	if randf() <= over: result += 1
	return result
