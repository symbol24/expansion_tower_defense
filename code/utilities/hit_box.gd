class_name HitBox extends Area2D


var _owner:Node2D


func _ready() -> void:
	_setup_hit_box_owner()


func set_new_owner(new_owner:Node2D) -> void:
	_owner = new_owner


func get_damage(target:Node2D) -> HpEffect:
	var hp_effect := HpEffect.new()
	hp_effect.setup_effect(target, _owner)
	hp_effect.value = _get_damage_from_owner()
	get_tree().create_timer(0.1).timeout.connect(_destroy_on_hit)
	return hp_effect.duplicate()


func _setup_hit_box_owner() -> void:
	if get_parent() is Enemy:
		_owner = get_parent()
		return

	if get_parent() is Building:
		_owner = get_parent()
		return


func _get_damage_from_owner() -> int:
	if _owner is Enemy:
		return _owner.data.damage
	
	return 0


func _destroy_on_hit() -> void:
	if _owner is Enemy:
		_owner.trigger_death()