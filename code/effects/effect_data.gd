class_name EffectData extends Resource


@export var id := &""
@export var trigger_count := 1
@export var trigger_delay := 0.0

var _owner:Node2D
var _target:Node2D
var _trigger_count := 0
var _timer := 0.0:
	set(value):
		_timer = value
		if _timer >= trigger_delay:
			apply_effect()
			_timer = 0.0


func add_time(delta:float) -> void:
	if trigger_delay > 0:
		_timer += delta


func apply_effect() -> void:
	# DO SOMETHING HERE
	_trigger_count += 1
	if _trigger_count >= trigger_count:
		_end_effect()


func setup_effect(target:Node2D, owner:Node2D) -> void:
	_target = target
	_owner = owner


func get_target() -> Node2D:
	return _target


func _end_effect() -> void:
	Signals.remove_effect.emit(self)
