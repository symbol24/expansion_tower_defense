class_name EffectData extends Resource


@export var id := &""
@export var trigger_count := 1
@export var trigger_delay := 0.0
@export var _target_name := &""
@export var _owner_name := &""

var _target:Node2D
var _trigger_count := 0
var _timer := 0.0:
	set(value):
		_timer = value
		if _timer >= trigger_delay:
			apply_effect(_target)
			_timer = 0.0


func add_time(delta:float) -> void:
	if trigger_delay > 0:
		_timer += delta


func apply_effect(target:Node2D) -> void:
	# DO SOMETHING HERE
	_target = target
	_trigger_count += 1
	if _trigger_count >= trigger_count:
		_end_effect()


func setup_effect(target:StringName, owner:StringName) -> void:
	_target_name = target
	_owner_name = owner


func get_target_name() -> StringName:
	return _target_name


func _end_effect() -> void:
	Signals.remove_effect.emit(self)
