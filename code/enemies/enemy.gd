class_name Enemy extends CharacterBody2D


var data:EnemyData
var _target:Building:
	get:
		if _target == null: _target = get_tree().get_first_node_in_group(&"tower")
		return _target


func _process(delta: float) -> void:
	_move(delta)

	move_and_slide()


func setup_enemy(new_data:EnemyData) -> void:
	data = new_data.duplicate()
	data.setup_data()


func trigger_death() -> void:
	data.state = EnemyData.DEAD
	Signals.return_enemy_to_pool.emit(self)


func update_hp(value:int) -> void:
	data.update_hp(-value)
	if data.state == EnemyData.DEAD:
		_death()


func _move(delta:float) -> void:
	if _target == null: return
	if data.state == EnemyData.MOVING:
		var direction := global_position.direction_to(_target.global_position)
		var x := move_toward(velocity.x, direction.x * data.speed, delta * Data.ACCELERATION)
		var y := move_toward(velocity.y, direction.y * data.speed, delta * Data.ACCELERATION)
		velocity = Vector2(x, y)
	else:
		if velocity != Vector2.ZERO: velocity = Vector2.ZERO


func _death() -> void:
	Signals.return_enemy_to_pool.emit(self)