extends Node


var player_data:PlayerData


func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS

	# DEBUG
	player_data = PlayerData.new()
	player_data.setup_data()