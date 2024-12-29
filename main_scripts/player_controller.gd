extends Node2D

var debug_territory: bool = false
@export var debug_selection = []

@onready var build_timer = preload("res://prefabs/build_timer.tscn")

@onready var tilemap: TileMap = get_node("tilemap")
@onready var selection_sprite = get_node("selection")
@onready var selection_sprite_tall = get_node("selection_tall")

@onready var time_label = get_node("gui/ui_main/time_control/timestamp")

var build_mode: bool = false
var selected_building: Vector2i = Vector2i(0, 0)

func _ready():
	get_node("gui/ui_main/time_control/time_mutliplier").text = str(game_con.time_multiplier) + "x"

func _unhandled_input(event):
	var tile = tilemap.local_to_map(get_global_mouse_position())
	var groundtiledata = tilemap.get_cell_tile_data(0, tile)
	var maintiledata = tilemap.get_cell_tile_data(1, tile)
	if maintiledata is TileData:
		var tile_terrain_type = maintiledata.get_custom_data_by_layer_id(0)
		
		if tile_terrain_type == "hill":
			selection_sprite_tall.visible = true
			selection_sprite.visible = false
			selection_sprite_tall.position = tilemap.map_to_local(tile)
		else:
			selection_sprite_tall.visible = false
			selection_sprite.visible = true
			selection_sprite.position = tilemap.map_to_local(tile)
	elif groundtiledata is TileData:
		selection_sprite_tall.visible = false
		selection_sprite.visible = true
		var tile_terrain_type = groundtiledata.get_custom_data_by_layer_id(0)
		selection_sprite.position = tilemap.map_to_local(tile)
	else:
		selection_sprite_tall.visible = false
		selection_sprite.visible = true
		selection_sprite.position = tilemap.map_to_local(tile) + Vector2(0, -8)
	
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_LEFT:
				if debug_territory:
					debug_selection.append(tile)
				if build_mode:
					if !tilemap.get_used_cells(1).has(tile) and tilemap.get_used_cells(0).has(tile):
						if game_con.client_nation._confirm_build(selected_building):
							var timer = build_timer.instantiate()
							timer.tilemap = tilemap
							timer.tileidx = tile
							timer.building = selected_building
							timer.build_time = gamedata.building_stats[selected_building][4]
							get_tree().current_scene.add_child(timer)
							tilemap.set_cell(1, tile, 0, Vector2i(1,0), 0)
							#tilemap.set_cell(1, tile, 0, selected_building, 0)
							#game_con.client_nation._scan_territory()
#			if event.button_index == MOUSE_BUTTON_RIGHT:
#				tilemap.erase_cell(1, tile)
				
	if event.is_action_pressed("pause"):
		game_con.paused = !game_con.paused
		get_node("gui/ui_main/time_control/pause_overlay").visible = !get_node("gui/ui_main/time_control/pause_overlay").visible

func _on_time_plus_pressed():
	game_con.increase_speed()
	get_node("gui/ui_main/time_control/time_mutliplier").text = str(game_con.time_multiplier) + "x"

func _on_time_minus_pressed():
	game_con.decrease_speed()
	get_node("gui/ui_main/time_control/time_mutliplier").text = str(game_con.time_multiplier) + "x"
