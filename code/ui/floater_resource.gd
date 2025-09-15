class_name FloaterResource extends TextureRect


const TARGET_HEIGHT := 96.0
const MOVE_TIME := 1.3


@export var type := &""


func start_floating(_position:Vector2) -> void:
	global_position = _position
	show()
	var final_pos := Vector2(global_position.x, global_position.y - TARGET_HEIGHT)
	var tween := create_tween()
	tween.finished.connect(_end)
	tween.tween_property(self, "global_position", final_pos, MOVE_TIME)


func _end() -> void:
	hide()
	Signals.return_floater_resource.emit(self)
