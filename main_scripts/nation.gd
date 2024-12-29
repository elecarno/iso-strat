extends Node
class_name Nation

@export var debug_nation_disabled: bool = false

@onready var tilemap: TileMap = get_parent().get_parent().get_node("tilemap")
@onready var termap: TileMap = get_parent().get_parent().get_node("territory")

enum IDEOLOGY {DEMOCRATIC, AUTHORITARIAN, MONARCHIST, COMMUNIST}

# nation stats
@export var nation_territory: Array = []
@export var territory_tile: Vector2i = Vector2i(0, 0)

@export var is_client_controlled = false
@export var is_player_controlled = false

@export var nation_name: String = "nation_name"
@export var nation_adjective: String = "nation_adjective"
@export var nation_ideology: String

var humanity: int = 0
var energy: int = 0
var pop: int = 0

var ether: int = 0
var ether_gain: int = 0
var fuel: int = 0
var fuel_gain: int = 1
var metals: int = 0
var metals_gain: int = 1
var rare_metals: int = 0
var rare_metals_gain: int = 0
var organics: int = 0
var organics_gain: int = 1
var commodities: int = 0
var commodities_gain: int = 1
var food: int = 0
var food_gain: int = 1

func _ready():
	for tile in termap.get_used_cells(0):
		if termap.get_cell_atlas_coords(0, tile) == territory_tile:
			nation_territory.append(tile)
	_scan_territory()

func _scan_territory():
	humanity = 0
	ether_gain = 0
	fuel_gain = 1
	metals_gain = 1
	rare_metals_gain = 0
	organics_gain = 1
	commodities_gain = 1
	food_gain = 1
	for tile in nation_territory:
		var tile_idx = tilemap.get_cell_atlas_coords(1, tile)
		if gamedata.building_stats.has(tile_idx):
			humanity += gamedata.building_stats[tile_idx][2][0]
			ether_gain += gamedata.building_stats[tile_idx][2][3]
			fuel_gain += gamedata.building_stats[tile_idx][2][4]
			metals_gain += gamedata.building_stats[tile_idx][2][5]
			rare_metals_gain += gamedata.building_stats[tile_idx][2][6]
			organics_gain += gamedata.building_stats[tile_idx][2][7]
			commodities_gain += gamedata.building_stats[tile_idx][2][8]
			food_gain += gamedata.building_stats[tile_idx][2][9]

func _add_gains():
	ether += ether_gain
	fuel += fuel_gain
	metals += metals_gain
	rare_metals += rare_metals_gain
	organics += organics_gain
	commodities += commodities_gain
	food += food_gain

func _confirm_build(building):
	if (ether >= gamedata.building_stats[building][3][0] 
	and fuel >= gamedata.building_stats[building][3][1]
	and metals >= gamedata.building_stats[building][3][2]
	and rare_metals >= gamedata.building_stats[building][3][3]
	and organics >= gamedata.building_stats[building][3][4]
	and commodities >= gamedata.building_stats[building][3][5]
	and food >= gamedata.building_stats[building][3][6]):
		ether -= gamedata.building_stats[building][3][0] 
		fuel -= gamedata.building_stats[building][3][1]
		metals -= gamedata.building_stats[building][3][2]
		rare_metals -= gamedata.building_stats[building][3][3]
		organics -= gamedata.building_stats[building][3][4]
		commodities -= gamedata.building_stats[building][3][5]
		food -= gamedata.building_stats[building][3][6]
		return true
	else:
		return false
		
