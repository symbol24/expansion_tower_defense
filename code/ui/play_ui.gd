class_name PlayUi extends RidControl


@onready var coins: Label = %coins
@onready var materials_label: Label = %materials
@onready var power: Label = %power


func _ready() -> void:
	Signals.send_power_dict.connect(_update_power)
	Signals.updated_resources.connect(_update_resources)


func _update_power(power_dict:Dictionary) -> void:
	power.text = str(power_dict[&"cost"]) + "/" + str(power_dict[&"production"])
	power.theme_type_variation = Data.RES_LABEL_NEGATIVE if power_dict[&"cost"] / power_dict[&"production"] else Data.RES_LABEL_NORMAL


func _update_resources(money := 0, materials := 0) -> void:
	coins.text = str(money)
	materials_label.text = str(materials)