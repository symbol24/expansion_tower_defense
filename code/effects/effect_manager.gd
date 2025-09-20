class_name EffectManager extends Node


var _owner:Node2D:
	get:
		if _owner == null: _owner = get_parent()
		return _owner
var _active_effects:Array[EffectData] = []


func _ready() -> void:
	Signals.add_effect.connect(_add_effect)
	Signals.remove_effect.connect(_remove_effect)


func _process(delta: float) -> void:
	for each in _active_effects:
		each.add_time(delta)


func _add_effect(effect:EffectData) -> void:
	if effect.get_target_name() != _owner.name: return
	var new_effect:EffectData = effect.duplicate(true)
	new_effect.apply_effect(_owner)
	_active_effects.append(new_effect)


func _remove_effect(effect:EffectData) -> void:
	if effect.get_target_name() != _owner.name: return
	var i := 0
	var found := false
	for each in _active_effects:
		if each == effect:
			found = true
			break
		i += 1

	if found:
		var _temp = _active_effects.pop_at(i)
