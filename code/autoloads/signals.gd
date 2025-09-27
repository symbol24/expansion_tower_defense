extends Node


# SCENEMANAGER
signal load_scene(id:StringName, disply_loading:bool, extra_time:bool)

# GAMEMANAGER
signal tick
signal start_match
signal building_purchase_result(building_data:BuildingData, approved:bool)
signal add_resources(building:Building)
signal updated_resources(money:int, materials:int)
signal end_match(won:bool)
signal time_updated(time:String)
signal start_level
signal add_resources_dict(dict:Dictionary)

# BUILDINGS
signal mouse_over_building(building:Building)
signal mouse_exit_building(building:Building)
signal build(data:BuildingData, pos:Vector2)
signal building_added(building:Building)
signal send_power_dict(result:Dictionary)
signal power_levels_to_low
signal power_levels_good
signal remove_building(building:Building)

# INPUTS
signal input_change_focus(id:StringName, is_focused:bool)
signal input_focuse_changed

# UI
signal display_build_menu(_position:Vector2)
signal ui_area_entered(ui_area:Control)
signal ui_area_exited(ui_panel:Control)
signal close_build_menus
signal clicked(item:Control)
signal toggle_rid_control(id:StringName, previous:StringName, display:bool)
signal request_power
signal build_request(building_data:BuildingData)
signal toggle_loading_screen(display:bool)
signal spawn_resource_floater(type:String, _position:Vector2)
signal return_floater_resource(floater:FloaterResource)
signal loading_screen_hidden
signal button_handling(destination:StringName)

# EFFECTS
signal add_effect(effect:EffectData)
signal remove_effect(effect:EffectData)

# ENEMIES
signal return_enemy_to_pool(enemy:Enemy)
signal check_death_for_resources(position:Vector2)

# OTHER
signal level_ready
signal kill_node(id:StringName)
signal debug_game_mode_type(type:BuildingData.Debug_Building_Type)
