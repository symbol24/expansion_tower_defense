class_name BuildAreaPanel extends Panel


func _ready() -> void:
	mouse_entered.connect(_mouse_enter)
	mouse_exited.connect(_mouse_exit)


func click() -> void:
	Signals.display_build_menu.emit(global_position)


func _mouse_enter() -> void:
	Signals.ui_area_entered.emit(self)


func _mouse_exit() -> void:
	Signals.ui_area_exited.emit(self)