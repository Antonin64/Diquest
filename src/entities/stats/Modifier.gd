extends Node2D
class_name Modifiers


@export var Stats = {
	"max_health_flat" = 0,
	"max_health" = 0,
	"damage_flat" = 0,
	"damage" = 0,
	"poison_dmg" = 0,
	"poison_tick_speed" = 0,
	"attack_speed" = 0,
	"life_regen" = 0,
	"stamina_regen" = 0,
	"stamina_flat" = 0,
	"stamina" = 0,
	"projectile_number" = 0,
	"life_steal" = 0,
	"life_gain_on_hit" = 0,
	"movement_speed" = 0,
	"critical_chance" = 0,
	"critical_damage" = 0,
	"damage_reduction" = 0,
}

@export var Stats_Range = {
	"max_health" : [5, 10],
	"max_health_flat" : [5, 10],
	"damage_flat" : [1, 2],
	"damage" : [5, 10],
	"poison_dmg" : [0.2, 0.4],
	"poison_tick_speed" : [1.05, 1.07],
	"attack_speed" : [1.04, 1.06],
	"life_regen" : [0.5, 0.7],
	"stamina_regen" : [0.03, 0.05],
	"stamina_flat" : [0.4, 0.7],
	"stamina" : [1.1, 1.2],
	"projectile_number" : [1, 1],
	"life_steal" : [5, 7],
	"life_gain_on_hit" : [1, 2],
	"movement_speed" : [3, 7],
	"critical_chance" : [3, 5],
	"critical_damage" : [5, 10],
	"damage_reduction" : [1, 3],
}

var rng  = RandomNumberGenerator.new()

func _ready():
	rng.seed = hash("Diquest")

func roll_random_modifier(modifiers_amt : int):
	var generated_nb = 0
	var rolled_modifier = {}
	var nb

	while (generated_nb < modifiers_amt):
		#roll the modifiers to be rolled
		nb = randi_range(0, len(Stats) - 1)
		if (rolled_modifier.has(Stats.keys()[nb])):
			continue

		rolled_modifier[Stats.keys()[nb]] = true
		generated_nb += 1
	
	#roll the stat range
	for stats_name in rolled_modifier:
		Stats[stats_name] = snapped(rng.randf_range(Stats_Range[stats_name][0], Stats_Range[stats_name][1]), 0.01)

func get_stats():
	return Stats
	
func get_stat(stat_name):
	if (Stats.has(stat_name)):
		return Stats[stat_name]
	return 0
