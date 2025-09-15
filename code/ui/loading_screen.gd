class_name LoadingScreen extends Control


const ROTATION_MULT := 0.5


@onready var logo: TextureRect = %logo


func _process(delta: float) -> void:
	if visible:
		logo.rotation += delta * ROTATION_MULT