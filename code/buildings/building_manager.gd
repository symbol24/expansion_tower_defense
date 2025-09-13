class_name BuildingManager extends Node2D


const OFFSET := Vector2(BuildMenuManager.CELL_SIZE/2, BuildMenuManager.CELL_SIZE/2)
const TOWER_DATA := preload("res://data/buildings/tower_data.tres")


var _buildings:Array[Building] = []


func _ready() -> void:
	Signals.build.connect(_build)
	_build(TOWER_DATA.duplicate(), BuildMenuManager.SCREEN_START)


func _build(data:BuildingData, pos:Vector2) -> void:
	var building:Building = _get_building(data)
	building.name = data.id + "_0"
	add_child(building)
	building.setup_building()
	building.global_position = pos + OFFSET
	Signals.building_added.emit(building)


func _get_building(data:BuildingData) -> Building:
	for each in _buildings:
		if each.data.id == data.id:
			return each.duplicate()

	var new_building:Building = load(data.path).instantiate()
	new_building.data = data
	_buildings.append(new_building)
	return new_building.duplicate()
