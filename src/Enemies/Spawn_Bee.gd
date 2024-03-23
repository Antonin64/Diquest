extends Node2D

var mob

func _ready():
	mob = load("res://Enemies/Bee/Bee.tscn").instantiate()
	mob.player_node = $"../CharacterBody2D"
	add_child(mob)
