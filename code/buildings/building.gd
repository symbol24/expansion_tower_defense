class_name Building extends Area2D


@export var starting_hp := 100
@export var power_usage := 1
@export var power_production := 0
@export var build_cost := 10

var data:BuildingData
var current_level := 0
var current_hp := 100.0
var max_hp := 100.0

@onready var mouse_over: Control = %mouse_over
@onready var hp_bar: ProgressBar = %hp_bar


func _ready() -> void:
	area_entered.connect(_area_entered)
	mouse_over.mouse_entered.connect(_mouse_enter)
	mouse_over.mouse_exited.connect(_mouse_exit)
	setup_building()


func setup_building() -> void:
	current_hp = starting_hp
	max_hp = starting_hp
	hp_bar.value = current_hp/max_hp


func toggle_hp_bar(value:bool) -> void:
	if value: hp_bar.show()
	else: hp_bar.hide()


func _update_hp(value:=0) -> void:
	current_hp += value
	if current_hp <= 0:
		pass
	elif current_hp >= max_hp:
		current_hp = max_hp


func _area_entered(area:Area2D) -> void:
	if area.has_method("get_damage"):
		_update_hp(area.get_damage())


func _mouse_enter() -> void:
	Signals.mouse_over_building.emit(self)


func _mouse_exit() -> void:
	Signals.mouse_exit_building.emit(self)
