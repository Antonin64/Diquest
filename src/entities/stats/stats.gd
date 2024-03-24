extends Node2D

var max_health = 100.0
var health = 100.0
var life_regen = 0.1
var damage = 1.0
var stamina = 1.0
var energy = 1.0
var stamina_regen = 0.2
var attack_speed = 1.0
var critical_chance = 5.0
var critical_damage = 50.0
var xp = 0
var level = 1
var needed_xp = 10
var gold = 0

@onready var energyregen = $EnergyRegen
@onready var liferegen = $LifeRegen

#Private var
var talent_point = 0

var modifiers = {}

#####  Getter  #####

func get_talent_point():
	return talent_point
	
func get_health():
	return health
	
func get_max_health():
	var num = max_health
	var stats
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("max_health_flat"):
			num += stats["max_health_flat"]
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("max_health"):
			num *= stats["max_health"]
	return num
	
func get_damage():
	var num = damage
	var stats
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("damage_flat"):
			num += stats["damage_flat"]
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("damage"):
			num *= 1 + stats["damage"]
	return num
	
func get_attack_speed():
	var num = attack_speed
	var stats
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("attack_speed"):
			num *=  1 + stats["attack_speed"]
	return num

func get_life_regen():
	var num = life_regen
	var stats
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("life_regen"):
			num += stats["life_regen"]
	return num
	
func get_stamina_regen():
	var num = stamina_regen
	var stats
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("stamina_regen"):
			num += stats["stamina_regen"]
	return num
	
func get_xp():
	return xp
	
func get_level():
	return level

func get_stamina():
	var num = stamina
	var stats
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("stamina_flat"):
			num += stats["stamina_flat"]
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("stamina"):
			num *= stats["stamina"]
	return num

func get_projectiles_count():
	var num = 1
	var stats
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("projectile_number"):
			num += stats["projectile_number"]
	return num

func get_life_steal():
	var num = 0
	var stats
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("life_steal"):
			num += stats["life_steal"]
	return num

func get_life_gain_on_hit():
	var num = 0
	var stats
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("life_gain_on_hit"):
			num += stats["life_gain_on_hit"]
	return num

func get_movement_speed_modifier():
	var num = 0
	var stats
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("movement_speed"):
			num += stats["movement_speed"] / 100
	return num
	
func get_critical_chance():
	var num = critical_chance
	var stats
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("critical_chance"):
			num += stats["critical_chance"]
	return num

func get_critical_damage():
	var num = critical_damage
	var stats
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("critical_damage"):
			num += stats["critical_damage"]
	return num
	
func get_damage_reduction():
	var num = 0
	var stats
	for modifier in modifiers:
		stats = modifiers[modifier].Stats
		if stats.has("damage_reduction"):
			num += stats["damage_reduction"] / 100
	return num

func get_energy():
	return energy

#####  Setter  #####

#talent point
func spend_talent_point():
	talent_point -=  1
	
func add_talent_point(amt):
	talent_point += amt 

#health
func add_health(amt):
	if (amt + health > get_max_health()):
		health = max_health
		return
	health += amt
	
func lose_health(amt):
	if (health - amt < 0):
		health = 0
		return
	health -= amt

#max_health
func set_max_health(amt):
	max_health = amt

func add_modifier(id, modifier):
	modifiers[id] = modifier
	print(get_movement_speed_modifier())
	
func add_energy(amt):
	if energy + amt > stamina:
		energy = stamina
		return
	energy += amt
	
func level_up():
	level += 1
	talent_point += 1

func add_xp(amt):
	xp += amt
	while xp >= needed_xp:
		xp -= needed_xp
		level_up()
		needed_xp += 0.5 * needed_xp
		
func add_gold(amt):
	gold += amt

func loose_energy(amt):
	if energy - amt < 0:
		energy = 0
		return
	energy -= amt
	
#regen

func regen():
	energyregen.start()
	liferegen.start()


func _on_life_regen_timeout():
	add_energy(get_stamina_regen())
	energyregen.start()


func _on_energy_regen_timeout():
	add_health(get_life_regen())
	liferegen.start()
	
