extends Node


var player_data:PlayerData
var _timers_active := false
var _active_level_timer := 0.0
var _last_match_timer := 0.0
var _mode_type:BuildingData.Debug_Building_Type


func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	Signals.start_level.connect(_start_level)
	Signals.build_request.connect(_build_request)
	Signals.add_resources.connect(_add_resources)
	Signals.add_resources_dict.connect(_add_resources_from_dict)
	Signals.end_match.connect(_end_match)
	Signals.debug_game_mode_type.connect(_set_mode_type)


func _process(delta: float) -> void:
	if _timers_active:
		_active_level_timer += delta
		Signals.time_updated.emit(_get_time_as_string(_active_level_timer))
		if _active_level_timer >= Data.SURVIVE_TIME:
			Signals.end_match.emit(true)


func get_current_match_time() -> float:
	return _active_level_timer


func get_last_match_timer() -> String:
	return _get_time_as_string(_last_match_timer)


func get_debug_mode_type() -> BuildingData.Debug_Building_Type:
	return _mode_type


func _start_level() -> void:
	player_data = PlayerData.new()
	player_data.setup_data()
	_timers_active = true
	Signals.updated_resources.emit(player_data.money, player_data.materials)
	Signals.start_match.emit()


func _build_request(building_data:BuildingData) -> void:
	var result:bool = building_data.money_cost <= player_data.money and building_data.material_cost <= player_data.materials
	if result: player_data.purchase_building(building_data)
	Signals.building_purchase_result.emit(building_data, result)


func _add_resources(building:Building) -> void:
	player_data.add_resources(building.data)


func _add_resources_from_dict(dict:Dictionary) -> void:
	player_data.add_resources_from_dict(dict)


func _end_match(_won:bool) -> void:
	get_tree().paused = true
	_timers_active = false
	_last_match_timer = _active_level_timer
	_active_level_timer = 0.0


func _get_time_as_string(_timer:float) -> String:
	var msec := fmod(_timer, 1) * 1000
	var sec := fmod(_timer, 60)
	var mins := fmod(_timer, 3600) / 60
	return "%02d:%02d.%03d" % [mins, sec, msec]


func _set_mode_type(type:BuildingData.Debug_Building_Type) -> void:
	_mode_type = type