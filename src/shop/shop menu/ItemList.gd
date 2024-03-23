extends ItemList

var indexes

func _ready():
	indexes = ["res://shop/bitcoin page/bitcoin_shop.tscn", "res://kyou/kyou_vert/minerai_vert.tscn"]

func _on_item_activated(index):
	get_tree().change_scene_to_file(indexes[index])
