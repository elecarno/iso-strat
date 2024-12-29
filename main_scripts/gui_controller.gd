extends CanvasLayer

@onready var player_con = get_tree().get_root().get_node("map")

func _process(delta):
	get_node("ui_main/nation_info/humanity").text = str(game_con.client_nation.humanity)
	get_node("ui_main/nation_info/ether").text = _format_resource_str(game_con.client_nation.ether, game_con.client_nation.ether_gain)
	get_node("ui_main/nation_info/fuel").text = _format_resource_str(game_con.client_nation.fuel, game_con.client_nation.fuel_gain)
	get_node("ui_main/nation_info/metals").text = _format_resource_str(game_con.client_nation.metals, game_con.client_nation.metals_gain)
	get_node("ui_main/nation_info/rare_metals").text = _format_resource_str(game_con.client_nation.rare_metals, game_con.client_nation.rare_metals_gain)
	get_node("ui_main/nation_info/organics").text = _format_resource_str(game_con.client_nation.organics, game_con.client_nation.organics_gain)
	get_node("ui_main/nation_info/commodities").text = _format_resource_str(game_con.client_nation.commodities, game_con.client_nation.commodities_gain)
	get_node("ui_main/nation_info/food").text = _format_resource_str(game_con.client_nation.food, game_con.client_nation.food_gain)

func _format_resource_str(data, gain):
	var result = ""
	if data >= 1000:
		result = "%.0f" % (data/1000) + "K +" + str(gain)
	else:
		result = str(data) + " +" + str(gain)
	return result

func _on_timestamp_mouse_entered():
	get_node("ui_main/time_control/timestamp_tooltip").visible = true

func _on_timestamp_mouse_exited():
	get_node("ui_main/time_control/timestamp_tooltip").visible = false

func _on_build_toggled(button_pressed):
	get_node("ui_main/toolbar/build_menu/build_info").visible = false
	if player_con.build_mode:
		player_con.build_mode = false
	get_node("ui_main/toolbar/build_menu").visible = !get_node("ui_main/toolbar/build_menu").visible

func _on_research_toggled(button_pressed):
	get_node("ui_main/toolbar/research_menu").visible = !get_node("ui_main/toolbar/research_menu").visible
