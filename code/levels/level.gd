class_name Level extends Node2D


var _input:MainGameInputProcess


func _ready() -> void:
	_setup_main_game_input()
	Signals.toggle_rid_control.emit(&"play_ui", &"", true)


func _setup_main_game_input() -> void:
	_input = MainGameInputProcess.new()
	add_child(_input)
	_input.name = &"main_game_input_process"
	_input.register()
