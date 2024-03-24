extends Button

func _on_pressed():
	$"../..".hide()
	$ForgeMenue.get_child(0).show()
