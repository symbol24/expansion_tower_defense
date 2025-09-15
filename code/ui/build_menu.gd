class_name BuildMenu extends Control


var _buttons:Array[BuildingButton] = []

@onready var button_hbox:HBoxContainer = %buttons
@onready var description_panel: PanelContainer = %description_panel
@onready var description_label: Label = %description_label


func _ready() -> void:
	Signals.ui_area_entered.connect(_ui_area_entered)
	Signals.ui_area_exited.connect(_ui_area_exited)
	description_panel.hide()


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


func _ui_area_entered(ui_area:Control) -> void:
	if ui_area is BuildingButton:
		if ui_area.data.description != "":
			description_label.text = ui_area.data.description
			description_panel.show()
		else:
			description_panel.hide()


func _ui_area_exited(ui_area:Control) -> void:
	if ui_area is BuildingButton:
		description_panel.hide()