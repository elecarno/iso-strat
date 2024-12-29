extends Control

@onready var player_con = get_tree().get_root().get_node("map")

func _format_build_info(building):
	get_node("build_info").visible = true
	var cost_grid = get_node("build_info/costs")
	var prod_grid = get_node("build_info/prods")
	get_node("build_info/name").text = gamedata.building_stats[building][0] + " | " + str(gamedata.building_stats[building][2][0]) + "HS"
	get_node("build_info/desc").text = gamedata.building_stats[building][1]
	get_node("build_info/build_time").text = "Build Time: " + str(gamedata.building_stats[building][4]) + "d"
	for i in range(0, len(gamedata.building_stats[building][3])):
		if gamedata.building_stats[building][3][i] == 0:
			cost_grid.get_child(i).visible = false
		else:
			cost_grid.get_child(i).visible = true
			cost_grid.get_child(i).get_node("label").text = str(gamedata.building_stats[building][3][i]) + " "
	for i in range(0, len(gamedata.building_stats[building][2])):
		if i < 3:
			continue
		if gamedata.building_stats[building][2][i] == 0:
			prod_grid.get_child(i-3).visible = false
		else:
			prod_grid.get_child(i-3).visible = true
			prod_grid.get_child(i-3).get_node("label").text = str(gamedata.building_stats[building][2][i]) + " "

