class_name Building extends Area2D


var data:BuildingData
var timer := 0.0:
	set(value):
		timer = value
		if timer >= Data.TICK_TIME:
			_trigger_building()
			timer = 0.0

@onready var mouse_over: Control = %mouse_over
@onready var hp_bar: ProgressBar = %hp_bar


func _ready() -> void:
	area_entered.connect(_area_entered)
	mouse_over.mouse_entered.connect(_mouse_enter)
	mouse_over.mouse_exited.connect(_mouse_exit)


func _process(delta: float) -> void:
	if data.is_active and data.tick_building: timer += delta


func setup_building(new_data:BuildingData) -> void:
	data = new_data.duplicate()
	data.setup_building_data()
	hp_bar.value = data.current_hp/data.max_hp
	data.is_active = true


func toggle_hp_bar(value:bool) -> void:
	if value: hp_bar.show()
	else: hp_bar.hide()


func _area_entered(area:Area2D) -> void:
	if area.has_method("get_damage"):
		data.update_hp(area.get_damage())
		hp_bar.value = data.current_hp/data.max_hp


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