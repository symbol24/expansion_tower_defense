class_name ResultScreen extends RidControl


@export var success_msg := "You have survived!"
@export var fail_msg := "You have been defeated..."
@export var timer_text := "Time Survived: %s"

@onready var result_text: Label = %result_text
@onready var btn_return: Button = %btn_return
@onready var time_survived: Label = %time_survived


func _ready() -> void:
	btn_return.pressed.connect(_return_btn_pressed)


func update_text(won:bool) -> void:
	if won:
		result_text.text = success_msg
	else:
		result_text.text = fail_msg
	time_survived.text = timer_text % Gm.get_last_match_timer()


func _return_btn_pressed() -> void:
	Signals.load_scene.emit(&"main_menu", true, true)