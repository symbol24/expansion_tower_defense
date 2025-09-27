class_name PlayUi extends RidControl


@onready var tick_coins: Label = %tick_coins
@onready var tick_materials: Label = %tick_materials
@onready var tick_power: Label = %tick_power
@onready var tick_time: Label = %tick_time
@onready var tick_panel: PanelContainer = %tick_panel
@onready var placement_panel: PanelContainer = %placement_panel
@onready var placement_coins: Label = %placement_coins
@onready var placement_materials: Label = %placement_materials
@onready var placement_power: Label = %placement_power
@onready var placement_time: Label = %placement_time


func _ready() -> void:
	Signals.send_power_dict.connect(_update_power)
	Signals.updated_resources.connect(_update_resources)
	Signals.time_updated.connect(_update_time)


func _update_power(power_dict:Dictionary) -> void:
	var to_update:Label
	match Gm.get_debug_mode_type():
		BuildingData.Debug_Building_Type.PLACEMENT:
			to_update = placement_power
		_:
			to_update = tick_power

	to_update.text = str(power_dict[&"cost"]) + "/" + str(power_dict[&"production"])
	to_update.theme_type_variation = Data.RES_LABEL_NEGATIVE if power_dict[&"cost"] / power_dict[&"production"] else Data.RES_LABEL_NORMAL


func _update_resources(money := 0, materials := 0) -> void:
	var coins:Label
	var materials_label:Label
	match Gm.get_debug_mode_type():
		BuildingData.Debug_Building_Type.PLACEMENT:
			coins = placement_coins
			materials_label = placement_materials
		_:
			coins = tick_coins
			materials_label = tick_materials

	coins.text = str(money)
	materials_label.text = str(materials)


func _update_time(value:String) -> void:
	var to_update:Label
	match Gm.get_debug_mode_type():
		BuildingData.Debug_Building_Type.PLACEMENT:
			to_update = placement_time
		_:
			to_update = tick_time

	to_update.text = value


func toggle_rid_control(_id:StringName, previous:StringName, display:bool) -> void:
	if _id != id:
		hide()
		return
	
	if display:
		tick_panel.hide()
		placement_panel.hide()
		match Gm.get_debug_mode_type():
			BuildingData.Debug_Building_Type.PLACEMENT:
				placement_panel.show()
			BuildingData.Debug_Building_Type.ROGUELITE:
				pass
			_:
				tick_panel.show()
		show()
	else:
		hide()

	_previous = previous
