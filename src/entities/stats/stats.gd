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
	for modifier in modifiers:
		if modifier.has("max_health_flat"):
			num += modifier["max_health_flat"]
	for modifier in modifiers:
		if modifier.has("max_health"):
			num *= modifier["max_health"]
	return num
	
func get_damage():
	var num = damage
	for modifier in modifiers:
		if modifier.has("damage_flat"):
			num += modifier["damage_flat"]
	for modifier in modifiers:
		if modifier.has("damage"):
			num *= modifier["damage"]
	return num
	
func get_attack_speed():
	var num = attack_speed
	for modifier in modifiers:
		if modifier.has("attack_speed"):
			num *= modifier["attack_speed"]
	return num

func get_life_regen():
	var num = life_regen
	for modifier in modifiers:
		if modifier.has("life_regen"):
			num += modifier["life_regen"]
	return num
	
func get_stamina_regen():
	var num = stamina_regen
	for modifier in modifiers:
		if modifier.has("stamina_regen"):
			num += modifier["stamina_regen"]
	return num

func get_stamina():
	var num = stamina
	for modifier in modifiers:
		if modifier.has("stamina_flat"):
			num += modifier["stamina_flat"]
	for modifier in modifiers:
		if modifier.has("stamina"):
			num *= modifier["stamina"]
	return num

func get_projectiles_count():
	var num = 1
	for modifier in modifiers:
		if modifier.has("projectile_number"):
			num += modifier["projectile_number"]
	return num

func get_life_steal():
	var num = 0
	for modifier in modifiers:
		if modifier.has("life_steal"):
			num += modifier["life_steal"]
	return num

func get_life_gain_on_hit():
	var num = 0
	for modifier in modifiers:
		if modifier.has("life_gain_on_hit"):
			num += modifier["life_gain_on_hit"]
	return num

func get_movement_speed_modifier():
	var num = 1
	for modifier in modifiers:
		if modifier.has("movement_speed"):
			num += modifier["movement_speed"]
	return num
	
func get_critical_chance():
	var num = critical_chance
	for modifier in modifiers:
		if modifier.has("critical_chance"):
			num += modifier["critical_chance"]
	return num

func get_critical_damage():
	var num = critical_damage
	for modifier in modifiers:
		if modifier.has("critical_damage"):
			num += critical_damage
	return num
	
func get_damage_reduction():
	var num = 0
	for modifier in modifiers:
		if modifier.has("damage_reduction"):
			num += modifier["damage_reduction"]
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
	
func loose_health(amt):
	if (health - amt < 0):
		health = 0
		return
	health -= amt

#max_health
func set_max_health(amt):
	max_health = amt

func add_modifier(id, modifier):
	modifiers[id] = modifier
	
func add_energy(amt):
	if energy + amt > stamina:
		energy = stamina
		return
	energy += amt

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
