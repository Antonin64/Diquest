extends Node2D

func _ready():
	$Pnj.get_child(0).get_child(0).node_interface = $"shop interface"
