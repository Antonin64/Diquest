extends Button

var state

var indexes

func _ready():
	indexes = ["res://kyou/kyou_vert/minerais_1.tres", "res://kyou/kyou_vert/minerais_2.tres", "res://kyou/kyou_vert/minerais_3.tres"]
	state = 0

func _on_pressed():
	state += 1
	if state < 3:
		$"..".texture = load(indexes[state])
