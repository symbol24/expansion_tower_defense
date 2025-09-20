class_name HpEffect extends EffectData


@export var value := 0


func apply_effect(target:Node2D) -> void:
	if _target_name  == target.name:
		_target = target
		_target.update_hp(value)

	_trigger_count += 1
	if _trigger_count >= trigger_count:
		_end_effect()
