extends Node

var tick: int = 43200 # used for game calculations
var last_day_tick: int = floor(tick/24)
var current_day_tick: int # used for day based game calculations
var time: float = 43200 # used to add to tick
var time_multiplier: float = 1 # game speed, 1.0 = 1 tick per second
const time_max: float = 30
const time_min: float = 0.5
var paused: bool = false

signal daytick

var nations
var client_nation

@onready var player_con = get_node("/root/map")

# Called when the node enters the scene tree for the first time.
func _ready():
	nations = get_node("/root/map/nations").get_children()
	for n in nations:
		if n.is_client_controlled:
			client_nation = n
	
func _process(delta):
	if not paused:
		time += (delta * time_multiplier)
		tick = floor(time)
		player_con.time_label.text = format_time()
		
		current_day_tick = floor(tick/24)
		nation_day_tick()
		
func nation_day_tick():
	if current_day_tick > last_day_tick:
		for n in nations:
			n._add_gains()
		emit_signal("daytick")
		last_day_tick = current_day_tick
		
func format_time():
	var hours = tick % 24
	var days = int(tick/24) % 30
	var months = int(tick/24/30) % 12 + 1
	var years = int(tick/24/30/12)
	return "%02d : %02d/%02d/%02d" % [hours, days, months, years]
	
func increase_speed():
	if time_multiplier < time_max:
		time_multiplier = floor(time_multiplier)
		if time_multiplier < 1:
			time_multiplier = 1
		elif time_multiplier < 10:
			time_multiplier += 9
		else:
			time_multiplier += 10
	
func decrease_speed():
	if time_multiplier > time_min:
		if time_multiplier == 1:
			time_multiplier = 0.5
		elif time_multiplier > 10:
			time_multiplier -= 10
		else:
			time_multiplier -= 9
