class_name EnemySpawner extends Node2D


@export var enemy_datas:Array[EnemyData] = []
@export var spawn_amount_range := Vector2i(1, 5)
@export var spawn_time_range := Vector2(0.66, 3)
@export var difficulty_brackets := [0, 60, 120, 180, 240]

var _pool:Array[Enemy] = []
var _active := false
var _delay := 0.0
var _timer := 0.0:
	set(value):
		_timer = value
		if _timer >= _delay:
			_spawn_enemies()
			_timer = 0.0


func _ready() -> void:
	Signals.return_enemy_to_pool.connect(_return_enemy_to_pool)
	Signals.start_match.connect(_start_spawning)


func _process(delta: float) -> void:
	if _active: _timer += delta


func _start_spawning() -> void:
	_spawn_enemies()
	_active = true


func _spawn_enemies() -> void:
	var i := randi_range(spawn_amount_range.x, spawn_amount_range.y)
	for j in i:
		_spawn_one_enemy(_get_enemy_data_to_spawn())
	_delay = randf_range(spawn_time_range.x, spawn_time_range.y)
	

func _spawn_one_enemy(data:EnemyData) -> void:
	var new_enemy:Enemy = _get_one_enemy(data)
	add_child(new_enemy)
	new_enemy.setup_enemy(data)
	new_enemy.name = data.id + &"_0"
	new_enemy.global_position = _get_spawn_point()


func _get_spawn_point() -> Vector2:
	var where:String = ["top", "bottom", "left", "right"].pick_random()
	var result:Vector2
	match where:
		"top":
			result = Vector2(randf_range(0.0, Data.SPAWN_OUTLINE.x), 0.0)
		"bottom":
			result = Vector2(randf_range(0.0, Data.SPAWN_OUTLINE.x), Data.SPAWN_OUTLINE.y)
		"left":
			result = Vector2(0.0, randf_range(0.0, Data.SPAWN_OUTLINE.y))
		_:
			result = Vector2(Data.SPAWN_OUTLINE.x, randf_range(0.0, Data.SPAWN_OUTLINE.y))

	return result


func _get_one_enemy(data:EnemyData) -> Enemy:
	var i := 0
	var found := false
	for each in _pool:
		if each.data.id == data.id:
			found = true
			break
		i += 1
	
	if found:
		return _pool.pop_at(i)
	
	var new_enemy:Enemy = load(data.path).instantiate()
	return new_enemy


func _return_enemy_to_pool(enemy:Enemy) -> void:
	#remove_child(enemy)
	#_pool.append(enemy)
	enemy.queue_free()


func _get_enemy_data_to_spawn() -> EnemyData:
	var i := 0
	var time := Gm.get_current_match_time()
	for upper in difficulty_brackets:
		if time <= upper:
			break
		i += 1
	
	if i > enemy_datas.size()-1:
		i = enemy_datas.size()-1
	
	var choice := randi_range(0, i)

	return enemy_datas[choice]
