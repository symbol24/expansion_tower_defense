class_name BuildMenu extends Control


var _buttons:Array[BuildingButton] = []

@onready var button_hbox:HBoxContainer = %buttons


func setup_menu(build_position:Vector2) -> void:
	if _buttons.is_empty():
		_populate_buttons()
	
	for each in _buttons:
		each.set_build_position(build_position)


func _populate_buttons() -> void:
	for each in Gm.player_data.available_buildings:
		var new_button:BuildingButton = Data.build_button.duplicate()
		button_hbox.add_child(new_button)
		new_button.setup_button(each)
		_buttons.append(new_button)
