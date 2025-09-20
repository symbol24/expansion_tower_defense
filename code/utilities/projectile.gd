class_name Projectile extends HitBox


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	_move(delta)


func setup_projectile(target:Node2D) -> void:
	look_at(target.global_position)


func _move(delta:float) -> void:
	if _owner and _owner.data:
		global_position += Vector2.RIGHT.rotated(rotation) * delta * _owner.data.speed


func _destroy_on_hit() -> void:
	queue_free()