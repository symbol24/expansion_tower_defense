class_name TeslaCoil extends AttackBuilding


const SECTION_LENGTH := Vector2(10, 50)
const ANGLE_VAR := 15.0


var _points:Array = []
var _final_point:Vector2
var _target_point:Vector2

@onready var line_point: Marker2D = %line_point
@onready var attack_line: Line2D = %attack_line


func setup_building(new_data:BuildingData) -> void:
	data = new_data.duplicate()
	data.setup_building_data()
	hp_bar.value = data.current_hp/data.max_hp
	data.is_active = true
	attack_area_collider.shape.radius = data.attack_range


func _shoot_one_bullet(target:Node2D) -> void:
	_display_line(target.global_position)
	target.update_hp(data.damage)


func _display_line(target_point:Vector2) -> void:
	_target_point = target_point
	_final_point = _target_point - line_point.global_position
	_create_line()


func _create_line() -> void:
	_update_points()
	attack_line.points = _points
	attack_line.set_visible(true)
	_hide_line()


func _hide_line() -> void:
	await get_tree().create_timer(0.3).timeout
	attack_line.set_visible(false)


func _update_points() -> void:
	var curr_line_len := 0.0
	_points = [Vector2.ZERO]
	var start_point := Vector2.ZERO
	while curr_line_len < Vector2.ZERO.distance_to(_final_point):
		var move_vector = start_point.direction_to(_final_point) * randf_range(SECTION_LENGTH.x, SECTION_LENGTH.y)
		var new_point = start_point + move_vector
		var new_point_rotated = start_point + move_vector.rotated(deg_to_rad(randf_range(-ANGLE_VAR, ANGLE_VAR)))
		_points.append(new_point_rotated)
		start_point = new_point
		curr_line_len = start_point.length()
	
