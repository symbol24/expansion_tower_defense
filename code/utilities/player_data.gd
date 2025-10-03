class_name PlayerData extends Node


const TICK_BUILDINGS := ["res://data/buildings/bank_data.tres", "res://data/buildings/factory_data.tres", "res://data/buildings/power_plant_data.tres", "res://data/buildings/tesla_coil_data.tres"]
const PLACEMENT_BUILDINGS := ["res://data/buildings/placement_bank_data.tres","res://data/buildings/power_plant_data.tres", "res://data/buildings/tesla_coil_data.tres", "res://data/buildings/placement_factory_data.tres"]
const STARTING_MONEY := 5
const STARTING_MATERIAL := 5


var energy_productions := 0
var energy_consumption := 0
var material_production := 0
var materials := 0
var money_production := 0
var money := 0
var available_buildings:Array[BuildingData] = []


func setup_data() -> void:
	_setup_starting_buildings()
	materials = STARTING_MATERIAL
	money = STARTING_MONEY


func add_resources(building_data:BuildingData) -> void:
	money += building_data.money_production
	materials += building_data.material_production
	Signals.updated_resources.emit(money, materials)


func add_resources_from_dict(dict:Dictionary) -> void:
	if dict.has(&"coins"):
		money += dict[&"coins"]
	if dict.has(&"coins"):
		materials += dict[&"materials"]
	Signals.updated_resources.emit(money, materials)


func purchase_building(building_data:BuildingData) -> void:
	money -= building_data.money_cost
	materials -= building_data.material_cost
	Signals.updated_resources.emit(money, materials)


func _setup_starting_buildings() -> void:
	var to_setup := []
	match Gm.get_gamemode():
		BuildingData.Building_Type.PLACEMENT:
			to_setup = PLACEMENT_BUILDINGS
		_:
			to_setup = TICK_BUILDINGS
	for each in to_setup:
		var new:BuildingData = load(each)
		available_buildings.append(new)