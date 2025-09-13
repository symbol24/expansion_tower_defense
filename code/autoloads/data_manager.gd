extends Node


var buils_area_panel_path := "res://scenes/ui/panel_area_selection.tscn"
var build_area_panel:Panel:
	get:
		if build_area_panel == null: build_area_panel = load(buils_area_panel_path).instantiate() as Panel
		return build_area_panel
var build_menu_path := "res://scenes/ui/build_menu.tscn"
var build_menu:Control:
	get:
		if build_menu == null: build_menu = load(build_menu_path).instantiate()
		return build_menu
var build_button_path := "res://scenes/ui/building_button.tscn"
var build_button:BuildingButton:
	get:
		if build_button == null: build_button = load(build_button_path).instantiate()
		return build_button
