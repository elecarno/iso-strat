extends Node2D

var tilemap: TileMap
var tileidx: Vector2i = Vector2i(0, 0)
var building: Vector2i = Vector2i(0, 0)

var hover: bool = false

var build_time: int = 10
var time: int = 0

func _ready():
	game_con.connect("daytick", _on_day_tick)
	position = tilemap.map_to_local(tileidx)
	get_node("time_label").text = gamedata.building_stats[building][0] + "\n" + str(build_time - time) + "d"

func _on_day_tick() -> void:
	time += 1
	get_node("time_label").text = gamedata.building_stats[building][0] + "\n" + str(build_time - time) + "d"
	if time >= build_time:
		_timeout()

func _timeout():
	if tilemap != null:
		tilemap.set_cell(1, tileidx, 0, building, 0)
		game_con.client_nation._scan_territory()
		queue_free()
