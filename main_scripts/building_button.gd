extends TextureButton

@onready var tex = preload("res://test_tileset.png")
@onready var build_menu = get_parent().get_parent()
@export var building: Vector2i = Vector2i(3, 1)

func _ready():
	var newtex = AtlasTexture.new()
	newtex.set_atlas(tex)
	newtex.set_region(Rect2(building.x * 32, building.y * 32, 32, 32))
	get_node("tex").texture = newtex

func _pressed():
	build_menu.player_con.build_mode = true
	build_menu.player_con.selected_building = building
	build_menu._format_build_info(build_menu.player_con.selected_building)
