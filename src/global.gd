extends Node

var current_scene = "cave"
var transition_scene = false
#exit cave
var player_exit_posx = 0
var player_exit_posy = 0
#enter to snow biome
var player_enter_posx = 0
var player_enter_posy = 0

func finish_changescene():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "cave":
			current_scene = "zone_snow"
		else:
			current_scene = "cave"
