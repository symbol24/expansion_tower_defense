class_name BuildMenuManager extends Control


const DIRECTIONS := ["up", "down", "left", "right"]
const MOUSE_OUT_AWAIT := 0.2


var _build_menu:BuildMenu
var _build_menu_displayed := false
var _panels:Array[BuildAreaPanel] = []
var _panels_displayed := false
var _can_close := true
var _hovered_building:Building
var _grid:Dictionary = {}


func _ready() -> void:
	Signals.display_build_menu.connect(_display_build_menu)
	Signals.close_build_menus.connect(_hide_build_menu)
	Signals.mouse_over_building.connect(_mouse_over_building)
	Signals.mouse_exit_building.connect(_mouse_exit_building)
	Signals.ui_area_entered.connect(_ui_area_entered)
	Signals.ui_area_exited.connect(_ui_area_exited)
	Signals.close_build_menus.connect(_close_build_menus)
	Signals.building_added.connect(_add_building)
	_setup_grid()


func _display_build_menu(build_position:Vector2 = Vector2(640, 360)) -> void:
	if _build_menu == null:
		_build_menu = Data.build_menu.duplicate()
		add_child(_build_menu)
	
	_build_menu.global_position = Vector2(build_position.x + 32, build_position.y)
	_build_menu.setup_menu(build_position)
	_build_menu.show()
	_build_menu_displayed = true


func _hide_build_menu() -> void:
	if _build_menu != null:
		_build_menu.hide()
		_build_menu.global_position = Vector2.ZERO
		_build_menu_displayed = false


func _menu_clicked(_item) -> void:
	_hide_build_menu()


func _mouse_over_building(building:Building) -> void:
	if _can_close and not _build_menu_displayed and _panels_displayed: _close_build_menus()
	if not _build_menu_displayed:
		if _panels.is_empty():
			_populate_panels()
		
		var i := 0
		for each in _panels:
			match DIRECTIONS[i]:
				"up":
					each.global_position = Vector2(building.global_position.x, building.global_position.y - Data.CELL_SIZE) - Data.OFFSET
				"down":
					each.global_position = Vector2(building.global_position.x, building.global_position.y + Data.CELL_SIZE) - Data.OFFSET
				"left":
					each.global_position = Vector2(building.global_position.x - Data.CELL_SIZE, building.global_position.y) - Data.OFFSET
				"right":
					each.global_position = Vector2(building.global_position.x + Data.CELL_SIZE, building.global_position.y) - Data.OFFSET
			
			if _grid[each.global_position/64 as Vector2i] == null: each.show()
			i += 1

		_hovered_building = building
		_hovered_building.toggle_hp_bar(true)
		_panels_displayed = true


func _populate_panels() -> void:
	for i in 4:
		var new_panel:BuildAreaPanel = Data.build_area_panel.duplicate()
		add_child(new_panel)
		new_panel.set_deferred(&"size", Vector2(Data.CELL_SIZE, Data.CELL_SIZE))
		_panels.append(new_panel)


func _mouse_exit_building(_building:Building) -> void:
	_can_close = true


func _ui_area_entered(ui_area:Control) -> void:
	if ui_area is BuildAreaPanel:
		_can_close = false


func _ui_area_exited(_ui_area:Control) -> void:
	if not _build_menu_displayed:
		_close_build_menus()


func _close_build_menus() -> void:
	_hide_build_menu()

	for each in _panels:
		each.hide()
	_panels_displayed = false

	if _hovered_building:
		_hovered_building.toggle_hp_bar(false)
		_hovered_building = null


func _setup_grid() -> void:
	var grid_size:Vector2i = Data.MAP_SIZE / Data.CELL_SIZE

	for x in grid_size.x:
		for y in grid_size.y:
			_grid[Vector2i(x, y)] = null


func _add_building(new_building:Building) -> void:
	var coords:Vector2i = Vector2i(new_building.global_position.x-Data.CELL_SIZE/2, new_building.global_position.y-Data.CELL_SIZE/2) / Data.CELL_SIZE
	_grid[coords] = new_building
