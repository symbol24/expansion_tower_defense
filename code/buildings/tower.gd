class_name Tower extends Building


@onready var attack_area: Area2D = %attack_area
@onready var attack_area_collider: CollisionShape2D = %attack_area_collider

var _projectile:Projectile
var _can_shoot := true
var _targets:Array[Node2D] = []
var _delay_active := false
var _timer := 0.0:
	set(value):
		_timer = value
		if _timer >= data.attack_delay:
			_can_shoot_again()


func _ready() -> void:
	super()
	attack_area.area_entered.connect(_attack_area_entered)


func _process(delta: float) -> void:
	super(delta)
	if not _can_shoot and _delay_active: _timer += delta
	if _can_shoot and not _delay_active and not _targets.is_empty(): _shoot_cycle()


func setup_building(new_data:BuildingData) -> void:
	super(new_data)
	attack_area_collider.shape.radius = data.attack_range
	_projectile = load(data.proj_path).instantiate()


func _shoot_cycle() -> void:
	if _targets.is_empty() or not _can_shoot: return
	_can_shoot = false
	var target = _get_closest_target()
	var i := 0
	while i < data.attack_count:
		if target != null: _shoot_one_bullet(target)
		if data.attack_count > 1: await get_tree().create_timer(0.1).timeout
		i += 1
	_delay_active = true
	_clean_targets()
	

func _shoot_one_bullet(target:Node2D) -> void:
	var new_projectile:Projectile = _projectile.duplicate()
	add_child.call_deferred(new_projectile)
	if not new_projectile.is_node_ready(): await new_projectile.ready
	new_projectile.set_new_owner(self)
	new_projectile.global_position = global_position
	new_projectile.setup_projectile(target)
	new_projectile.name = name + &"_proj_0"


func _can_shoot_again() -> void:
	_timer = 0.0
	_delay_active = false
	_can_shoot = true
	_shoot_cycle()


func _attack_area_entered(area:Area2D) -> void:
	if area.get_parent() is Enemy:
		_targets.append(area.get_parent())


func _get_closest_target() -> Node2D:
	var distance := 1000000000000000000.0
	var target:Node2D = null
	for each in _targets:
		if each != null:
			if target != null:
				if global_position.distance_squared_to(each.global_position) < distance:
					target = each
					distance = global_position.distance_squared_to(each.global_position)
			else:
				target = each
				distance = global_position.distance_squared_to(each.global_position)
	
	return target


func _clean_targets() -> void:
	var poses:Array[int] = []
	var i := 0
	for each in _targets:
		if each == null:
			poses.append(i)
		i += 1
	
	poses.reverse()
	for x in poses:
		_targets.remove_at(x)
