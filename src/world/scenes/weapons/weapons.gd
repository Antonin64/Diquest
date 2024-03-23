extends Node2D

var dmg = 1
var atk_speed = 1
var type = "sword"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func sword_attack():
	var arr = $attack_orientation/Area2D.get_overlapping_bodies()
	for i in arr:
		i.take_damage()

func set_sword(sword):
	type = "sword"
	if (sword == "sword_common"):
		$attachment/Sprite2D.set_texture("res://world/assets/weapons/swords/sword_common.png")
		$Modifier.damage = 1
	if (sword == "sword_uncommon"):
		$attachment/Sprite2D.set_texture("res://world/assets/weapons/swords/sword_uncommon.png")
		$Modifier.damage = 3
	if (sword == "sword_rare"):
		$attachment/Sprite2D.set_texture("res://world/assets/weapons/swords/sword_rare.png")
		$Modifier.damage = 6
	if (sword == "sword_epic"):
		$attachment/Sprite2D.set_texture("res://world/assets/weapons/swords/sword_epic.png")
		$Modifier.damage = 12
	if (sword == "sword_legendary"):
		$attachment/Sprite2D.set_texture("res://world/assets/weapons/swords/sword_legendary.png")
		$Modifier.damage = 20
	if (sword == "sword_mythical"):
		$attachment/Sprite2D.set_texture("res://world/assets/weapons/swords/sword_mythical.png")
		$Modifier.damage = 25
