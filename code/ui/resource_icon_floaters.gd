class_name ResourceIconFloaters extends Control


var _coin_pool:Array[TextureRect] = []
var _material_pool:Array[TextureRect] = []

@onready var positioner:Node2D = %positioner


func _ready() -> void:
	Signals.spawn_resource_floater.connect(_spawn_resource_floater)
	Signals.return_floater_resource.connect(_return_floater)


func _spawn_resource_floater(type := "coin", _position := Vector2(640, 360)) -> void:
	var resource:FloaterResource = _get_resource(type)
	add_child(resource)
	resource.start_floating(_position + get_global_transform_with_canvas().origin)


func _get_resource(type := "coin") -> FloaterResource:
	if type == "coin":
		if not _coin_pool.is_empty():
			return _coin_pool.pop_front()
		return Data.floater_coin.duplicate()
	else:
		if not _material_pool.is_empty():
			return _material_pool.pop_front()
		return Data.floater_materials.duplicate()


func _return_floater(floater:FloaterResource) -> void:
	remove_child(floater)
	if floater.type == &"coin":
		_coin_pool.append(floater)
	else:
		_material_pool.append(floater)
