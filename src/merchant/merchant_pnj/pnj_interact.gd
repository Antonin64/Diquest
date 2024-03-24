extends Button

var node_interface

func _on_pressed():
	node_interface.get_child(0).show()
