class_name MainMenu extends RidControl


@export var explanation_text := "Survive %s minutes. Buildings produce MONEY, MATERIALS and POWER. Use Tesla Coils to defend your main base. Sorry for the lack of content. You can only build new buildings around current buildings. Mouse over buildings to show where you can build. Click on the build positions to show build menu."

@onready var explanation: Label = %explanation


func _ready() -> void:
	explanation.text = explanation_text % int(Data.SURVIVE_TIME/60)