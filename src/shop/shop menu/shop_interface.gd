extends Control


func _ready():
	get_child(0).hide()

func _on_visibility_changed():
	global_position = $"../NavigationRegionBee/CharacterBody2D".get_child(4).global_position
