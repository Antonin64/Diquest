extends Node2D

var mob

func _ready():
	mob = load("res://Enemies/Skeleton/Skeleton.tscn").instantiate()
	mob.player_node = $"../CharacterBody2D"
	add_child(mob)

func _process(_delta):
	if mob == null and $Timer.is_stopped():
		$Timer.start()

func _on_timer_timeout():
	mob = load("res://Enemies/Skeleton/Skeleton.tscn").instantiate()
	mob.player_node = $"../CharacterBody2D"
	add_child(mob)
