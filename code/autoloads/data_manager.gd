extends Node


# GAME CONST
const TICK_TIME := 5.0

# UI CONST
const BB_POSITIVE_LABEL := &"BB_positive_label"
const BB_NEGATIVE_LABEL := &"BB_negative_label"
const RES_LABEL_NEGATIVE := &"Res_Label_Negative"
const RES_LABEL_NORMAL := &"Res_Labels"
const LOADING_SCREEN_PATH := "res://scenes/ui/loading_screen.tscn"
const PLAY_UI_PATH := "res://scenes/ui/play_ui.tscn"
const MAIN_MENU_PATH := "res://scenes/ui/main_menu.tscn"
const BOOT_INTROS_PATH := "res://scenes/ui/boot_intros.tscn"
const BUILD_AREA_PANEL_PATH := "res://scenes/ui/panel_area_selection.tscn"
const BUILD_MENU_PATH := "res://scenes/ui/build_menu.tscn"
const BUILD_BUTTON_PATH := "res://scenes/ui/building_button.tscn"
const FLOATER_COIN_PATH := "res://scenes/ui/floater_coin.tscn"
const FLOATER_MATERIALS_PATH := "res://scenes/ui/floater_material.tscn"

# BUILDINGS
const OFFSET := Vector2(CELL_SIZE/2, CELL_SIZE/2)
const TOWER_DATA := preload("res://data/buildings/tower_data.tres")

# LEVEL AND GRIP
const CELL_SIZE := 64
const MAP_SIZE := Vector2i(1920, 1080)
const SCREEN_START := MAP_SIZE/2

# ENEMIES
const SPAWN_OUTLINE := Vector2(1920, 1080)
const FRICTION := 700.0
const ACCELERATION := 500.0

# UI VARS
var build_area_panel:Panel:
	get:
		if build_area_panel == null: build_area_panel = load(BUILD_AREA_PANEL_PATH).instantiate() as Panel
		return build_area_panel
var build_menu:Control:
	get:
		if build_menu == null: build_menu = load(BUILD_MENU_PATH).instantiate()
		return build_menu
var build_button:BuildingButton:
	get:
		if build_button == null: build_button = load(BUILD_BUTTON_PATH).instantiate()
		return build_button
var floater_coin:FloaterResource:
	get:
		if floater_coin == null: floater_coin = load(FLOATER_COIN_PATH).instantiate()
		return floater_coin
var floater_materials:FloaterResource:
	get:
		if floater_materials == null: floater_materials = load(FLOATER_MATERIALS_PATH).instantiate()
		return floater_materials