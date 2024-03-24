extends Node2D

@onready var modifier = $Modifier
var sword_damage = 1

func player_attack(vector_dir : Vector2, damage : int):
	sword_damage = damage
	$attack_orientation.visible = true
	$attack_orientation.rotation = vector_dir.angle()
	$attack_orientation/attachment/atk_anim.play("sword_attack", -1, 1, false)

func hide_sword():
	$attack_orientation.visible = false

func _is_sword_hitting():
	var arr = $attack_orientation/Area2D.get_overlapping_bodies()
	for i in arr:
		i.take_damage(sword_damage)
