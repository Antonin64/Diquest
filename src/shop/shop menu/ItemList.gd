extends ItemList

var indexes

func _ready():
	indexes = ["res://shop/comon sword page/comon_sword_page.tscn", "res://shop/uncomon sword page/uncomon_sword_page.tscn", "res://shop/rare sword page/rare_sword_page.tscn"]

func _on_item_activated(index):
	get_tree().change_scene_to_file(indexes[index])
