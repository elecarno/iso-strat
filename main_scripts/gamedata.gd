extends Node

var building_stats = {
					#[Humanity, Elec Cost, Elec Prod, E, FU, M, RM, R, O, C, FO], [resources in order], build_time
	Vector2i(1, 1): ["City", "A large urban population center.", [30, 0, 0, 0, 0, 0, 0, 0, 3, 0]],
	Vector2i(1, 2): ["Town", "A developing urban population.", [15, 0, 0, 0, 0, 0, 0, 0, 2, 0]],
	Vector2i(1, 3): ["Village", "The beginnings of a population center.", [10, 0, 0, 0, 0, 0, 0, 0, 1, 0], [0, 0, 50, 0, 100, 0, 0], 160],
	
	Vector2i(3, 1): ["Farmland", "An expanse of land dedicated to crop.", [3, 0, 0, 0, 0, 0, 0, 0, 0, 2], [0, 0, 10, 0, 50, 0, 0], 50],
	Vector2i(3, 2): ["Greenhouses", "More efficient & durable alternatives to farmland.", [3, 0, 0, 0, 0, 0, 0, 0, 0, 5], 120],
	Vector2i(3, 3): ["Forestry Dist.", "A region of forest maintained for materials.", [3, 0, 0, 0, 0, 0, 0, 3, 1, 0], [0, 0, 0, 0, 70, 30, 0], 300],
	
	Vector2i(4, 1): ["Coal Mine", "Scrapes the barren crust of the planet for any remnants of fossil fuels.", [1, 0, 0, 0, 3, 0, 0, 0, 0, 0], [0, 0, 150, 15, 20, 0, 0], 150],
	Vector2i(4, 2): ["Metals Mine", "A large industrial district dedicated to the extraction of minerals.", [2, 0, 0, 0, 0, 5, 0, 0, 0, 0], [0, 50, 210, 30, 15, 0, 0], 160],
	Vector2i(4, 3): ["Rare M. Mine", "A large industrial district dedicated to the extraction of rare and increasingly valuable minerals.", [1, 0, 0, 0, 0, 0, 3, 0, 0, 0], [0, 75, 300, 00, 50, 0, 0], 200],
	
	Vector2i(5, 1): ["Civ. Factory", "Produces goods for the people.", [3, 0, 0, 0, 0, 0, 0, 0, 3, 0], [0, 50, 150, 10, 150, 0, 0], 150],
	Vector2i(5, 2): ["Mat. Factory", "Produces key materials necessary in many industries.", [2, 0, 0, 0, 0, 0, 0, 5, 0, 0], [0, 30, 150, 50, 0, 0, 0], 170],
}
