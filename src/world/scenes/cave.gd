extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


func _on_transi_to_snow_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true


func _on_transi_to_snow_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false
		
func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "cave":
			get_tree().change_scene_to_file("res://world/scenes/zone_snow.tscn")
			Global.finish_changescene()
