class_name EnemyData extends Resource


enum {IDLE, MOVING, ATTACKING, DEAD}


@export var id := &""
@export var path := ""

@export_category("Stats")
@export var starting_hp := 1
@export var starting_damage := 1
@export var starting_speed := 10.0

var state := IDLE
var level := 1
var current_hp := 0
var max_hp := 0
var speed := 0.0
var damage := 0


func setup_data() -> void:
	max_hp = starting_hp + ((level-1) * 0.2 * starting_hp)
	current_hp = max_hp
	speed = starting_speed + ((level-1) * 0.1 * starting_hp)
	damage = starting_damage + ((level-1) * 0.5 * starting_hp)
	state = MOVING


func update_hp(value:int) -> void:
	current_hp = clampi(current_hp + value, 0, max_hp)
	if current_hp <= 0:
		state = DEAD