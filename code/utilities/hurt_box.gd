class_name HurtBox extends Area2D


var _parent:Node2D:
	get:
		if _parent == null: _parent = get_parent()
		return _parent


func _ready() -> void:
	area_entered.connect(_area_entered)


func _area_entered(area:Area2D) -> void:
	if area.has_method("get_damage"):
		_parent.update_hp(area.get_damage())
