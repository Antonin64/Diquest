extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false

func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "snow_zone":
			get_tree().change_scene_to_file("res://world/scenes/cave.tscn")
			Global.finish_changescene()
