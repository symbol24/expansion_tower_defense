class_name MainGameInputProcess extends InputProcess


var _hover_item:Control = null


func _ready() -> void:
	id = &"main_game"
	Signals.ui_area_entered.connect(_item_entered)
	Signals.ui_area_exited.connect(_item_exited)


func process_input(_delta:float, _event:InputEvent) -> void:
	if _event != null:
		if _event.is_action_released(&"click"):
			if _hover_item != null and _hover_item.has_method(&"click"):
				_hover_item.click()
			Signals.clicked.emit(_hover_item)
		elif _event.is_action_released(&"back"):
			_back_clicked()


func _item_entered(control:Control) -> void:
	if control != null:
		_hover_item = control


func _item_exited(control:Control) -> void:
	if control == _hover_item:
		_hover_item = null


func _back_clicked() -> void:
	_hover_item = null
	Signals.close_build_menus.emit()
