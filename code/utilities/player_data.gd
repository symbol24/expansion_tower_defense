class_name PlayerData extends Node


const STARTING_BUILDINGS := ["res://data/buildings/bank_data.tres", "res://data/buildings/factory_data.tres", "res://data/buildings/power_plant_data.tres", "res://data/buildings/tesla_coil_data.tres"]


var energy_productions := 0
var energy_consumption := 0
var material_production := 0
var materials := 0
var money_production := 0
var money := 0

var available_buildings:Array[BuildingData] = []


func setup_data() -> void:
	_setup_starting_buildings()


func _setup_starting_buildings() -> void:
	for each in STARTING_BUILDINGS:
		var new:BuildingData = load(each)
		available_buildings.append(new)