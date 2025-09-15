extends Node


var player_data:PlayerData
var _timers_active := false
var _active_level_timer := 0.0


func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	Signals.level_ready.connect(_start_level)
	Signals.build_request.connect(_build_request)
	Signals.add_resources.connect(_add_resources)

	# DEBUG
	player_data = PlayerData.new()
	player_data.setup_data()


func _process(delta: float) -> void:
	if _timers_active:
		_active_level_timer += delta


func get_current_match_time() -> float:
	return _active_level_timer


func _start_level() -> void:
	_timers_active = true
	Signals.updated_resources.emit(player_data.money, player_data.materials)
	Signals.start_match.emit()


func _build_request(building_data:BuildingData) -> void:
	var result:bool = building_data.money_cost <= player_data.money and building_data.material_cost <= player_data.materials
	if result: player_data.purchase_building(building_data)
	Signals.building_purchase_result.emit(building_data, result)


func _add_resources(building:Building) -> void:
	player_data.add_resources(building.data)