class_name RidControl extends Control


@export var id := &""

var _previous := &""


func toggle_rid_control(_id:StringName, previous:StringName, display:bool) -> void:
	if _id != id:
		hide()
		return
	
	# Do something here
	if display:
		show()
	else:
		hide()

	_previous = previous