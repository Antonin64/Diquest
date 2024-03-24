extends Area2D

func _on_body_entered(body):
	if body == $"../NavigationRegionBee/CharacterBody2D" and Global.ok == false:
		Global.change_map(2, $"../NavigationRegionBee/CharacterBody2D")
