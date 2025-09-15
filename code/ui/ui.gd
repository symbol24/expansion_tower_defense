extends CanvasLayer


var _rid_controls:Array[RidControl] = []
var _active_control := &""
var _loading_screen:LoadingScreen


func _ready() -> void:
	Signals.toggle_rid_control.connect(_toggle_rid_controls)
	Signals.toggle_loading_screen.connect(_toggle_loading_screen)


func _toggle_rid_controls(id:StringName, previous:StringName, display:bool) -> void:
	var found := false
	for each in _rid_controls:
		each.toggle_rid_control(id, previous, display)
		if each.id == id: 
			found = true
			move_child(each, get_child_count()-2)

	if not found:
		var new_rid:RidControl = _get_rid_control(id)
		new_rid.toggle_rid_control(id, previous, display)
		move_child(new_rid, get_child_count()-2)

	_active_control = id


func _toggle_loading_screen(display:bool) -> void:
	if _loading_screen != null:
		if display:
			move_child(_loading_screen, get_child_count())
			_loading_screen.show()
		else: _loading_screen.hide()
		return
	
	_loading_screen = load(Data.LOADING_SCREEN_PATH).instantiate()
	add_child(_loading_screen)
	move_child(_loading_screen, get_child_count())


func _get_rid_control(id:StringName) -> RidControl:
	var result:RidControl
	var to_load:String
	match id:
		&"play_ui":
			to_load = Data.PLAY_UI_PATH
		&"main_menu":
			to_load = Data.MAIN_MENU_PATH
		&"boot_intros":
			to_load = Data.BOOT_INTROS_PATH
		_:
			pass
	
	result = load(to_load).instantiate()
	add_child(result)
	_rid_controls.append(result)
	return result
