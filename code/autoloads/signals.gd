extends Node


# BUILDINGS
signal mouse_over_building(building:Building)
signal mouse_exit_building(building:Building)
signal build(data:BuildingData, pos:Vector2)
signal building_added(building:Building)

# INPUTS
signal input_change_focus(id:StringName, is_focused:bool)
signal input_focuse_changed

# UI
signal display_build_menu(position:Vector2)
signal ui_area_entered(ui_area:Control)
signal ui_area_exited(ui_panel:Control)
signal close_build_menus
signal clicked(item:Control)
