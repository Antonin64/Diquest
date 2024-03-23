extends Node2D

var max_health : int = 100
var health : int = 100

var talent_point = 0

#####  Getter  #####

func get_talent_point():
	return talent_point
	
func get_health():
	return health
	
func get_max_health():
	return max_health

#####  Setter  #####

#talent point
func spend_talent_point():
	talent_point -=  1
	
func add_talent_point(amt):
	talent_point += amt 

#health
func add_health(amt):
	if (amt + health > max_health):
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
