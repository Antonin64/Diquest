extends Node2D

@onready var dmg = 1
@onready var atk_speed = 1
@onready var type = "sword"
@onready var modifier = $Modifier

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func player_attack():
	if (type == "sword"):
		$attack_orientation/attachment/atk_anim.play("sword_attack", -1, 1, false)

func is_sword_hit():
	var arr = $attack_orientation/Area2D.get_overlapping_bodies()
	for i in arr:
		i.take_damage()

func set_sword(sword):
	type = "sword"
	if (sword == "sword_common"):
		$attachment/Sprite2D.set_texture("res://world/assets/weapons/swords/sword_common.png")
		modifier.Stats["damage"] = 1
	if (sword == "sword_uncommon"):
		$attachment/Sprite2D.set_texture("res://world/assets/weapons/swords/sword_uncommon.png")
		modifier.Stats["damage"] = 3
	if (sword == "sword_rare"):
		$attachment/Sprite2D.set_texture("res://world/assets/weapons/swords/sword_rare.png")
		modifier.Stats["damage"] = 6
	if (sword == "sword_epic"):
		$attachment/Sprite2D.set_texture("res://world/assets/weapons/swords/sword_epic.png")
		modifier.Stats["damage"] = 12
	if (sword == "sword_legendary"):
		$attachment/Sprite2D.set_texture("res://world/assets/weapons/swords/sword_legendary.png")
		modifier.Stats["damage"] = 20
	if (sword == "sword_mythical"):
		$attachment/Sprite2D.set_texture("res://world/assets/weapons/swords/sword_mythical.png")
		modifier.Stats["damage"] = 30
