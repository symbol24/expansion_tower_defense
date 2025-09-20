class_name AttackBuildingData extends BuildingData


@export var attack_range := 1.0
@export var attack_count := 1
@export var attack_delay := 1.0
@export var is_projectile := true
@export var proj_damage := 1.0
@export var proj_speed := 1.0
@export var proj_path := ""

var damage := 1.0
var speed := 1.0


func setup_building_data() -> void:
	super()
	damage = proj_damage
	speed = proj_speed