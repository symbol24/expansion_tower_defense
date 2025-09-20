class_name Building extends Area2D


const POWER_OFF_CYCLE := 1.0


var data:BuildingData
var _tick_time := 0.0
var timer := 0.0:
	set(value):
		timer = value
		if timer >= _tick_time:
			_trigger_building()
			timer = 0.0
var _power_off_cycling := false
var _power_off_modulate_color:Color
var _low_power := false

@onready var mouse_over: Control = %mouse_over
@onready var hp_bar: ProgressBar = %hp_bar
@onready var power_off_icon:TextureRect = %power_off


func _ready() -> void:
	area_entered.connect(_area_entered)
	mouse_over.mouse_entered.connect(_mouse_enter)
	mouse_over.mouse_exited.connect(_mouse_exit)
	Signals.power_levels_good.connect(_power_levels_good)
	Signals.power_levels_to_low.connect(_power_level_to_low)
	_power_off_modulate_color = power_off_icon.modulate
	power_off_icon.modulate = Color.TRANSPARENT
	_tick_time = Data.TICK_TIME
	toggle_hp_bar(false)


func _process(delta: float) -> void:
	if data.is_active:
		if data.tick_building: timer += delta
		if _low_power and not _power_off_cycling:
			_play_power_off_cycle()


func setup_building(new_data:BuildingData) -> void:
	data = new_data.duplicate()
	data.setup_building_data()
	hp_bar.value = data.current_hp/data.max_hp
	data.is_active = true


func toggle_hp_bar(value:bool) -> void:
	if value: hp_bar.show()
	else: hp_bar.hide()	


func update_hp(value:int) -> void:
	data.update_hp(value)
	hp_bar.value = data.current_hp/data.max_hp
	_timer_display_hp()


func _timer_display_hp() -> void:
	if not hp_bar.visible:
		toggle_hp_bar(true)
		await get_tree().create_timer(3.0).timeout
		toggle_hp_bar(false)


func _area_entered(area:Area2D) -> void:
	if area.has_method("get_damage"):
		update_hp(-area.get_damage())


func _mouse_enter() -> void:
	Signals.mouse_over_building.emit(self)


func _mouse_exit() -> void:
	Signals.mouse_exit_building.emit(self)


func _trigger_building() -> void:
	if data.money_production > 0:
		Signals.spawn_resource_floater.emit("coin", Vector2(global_position.x + randf_range(-20, 0), global_position.y))
	if data.material_production > 0:
		Signals.spawn_resource_floater.emit("material", Vector2(global_position.x + randf_range(0, 20), global_position.y))
	Signals.add_resources.emit(self)


func _power_level_to_low() -> void:
	if not data.can_low_power: return
	_low_power = true
	_tick_time = Data.TICK_TIME * 2


func _power_levels_good() -> void:
	_low_power = false
	_tick_time = Data.TICK_TIME


func _play_power_off_cycle() -> void:
	_power_off_cycling = true
	power_off_icon.show()
	var tween := create_tween()
	tween.tween_property(power_off_icon, "modulate", Color.TRANSPARENT, POWER_OFF_CYCLE)
	tween.tween_property(power_off_icon, "modulate", _power_off_modulate_color, POWER_OFF_CYCLE)
	await tween.finished
	power_off_icon.hide()
	_power_off_cycling = false