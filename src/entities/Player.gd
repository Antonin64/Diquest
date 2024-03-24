extends CharacterBody2D

#constant
const SPEED = 120.0
const JUMP_VELOCITY = -400.0
const DASH_SPEED = 470
const DASH_DURATION = 0.12

var Modifier_class = load("res://entities/stats/Modifier.gd")

#public var
@export var Modifier : Modifiers
@export var max_hp : int  = 100
@export var hp : int  = 100
@onready var dash = $Dash
@onready var stats = $Stats
@onready var inventory = []
@onready var inventory_size = 10
@onready var equiped_sword
@onready var sword_sprite = $Weapons/attack_orientation/attachment/sword
@onready var inventory_buttons = [$Inventory_UI/slot1, $Inventory_UI/slot2, $Inventory_UI/slot3, $Inventory_UI/slot4, $Inventory_UI/slot5, $Inventory_UI/slot6, $Inventory_UI/slot7, $Inventory_UI/slot8, $Inventory_UI/slot9, $Inventory_UI/slot10]

var dash_direction

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

##### combat #####

func _ready():
	stats.regen()
	$Weapons/attack_orientation.visible = false
	add_item("sword_common")
	add_item("sword_common")
	add_item("sword_mythical")
	add_item("sword_legendary")
	equip_item(inventory[0])
	hide_inventory()

func apply_damage(amount : int):
	if (dash.is_dashing()):
		return
	stats.loose_health(amount)

func die():
	if (stats.get_health() <= 0):
		1
		#TODO die

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	anim_player((direction))
	if Input.is_action_pressed("dash"):
		if stats.get_energy() >= 1:
			dash.start_dash(DASH_DURATION)
			stats.loose_energy(1)
			dash_direction = direction
	if Input.is_action_just_pressed("attack"):
		$Weapons.player_attack(get_global_mouse_position() - Vector2($".".get_global_position()), equiped_sword.Stats["damage"])
	if Input.is_action_just_pressed("toggle_inventory"):
		if $Inventory_UI.visible == true:
			hide_inventory()
		else:
			show_inventory()

#movement direction
	var cur_speed = DASH_SPEED if dash.is_dashing() else SPEED
	if (dash.is_dashing()):
		velocity = dash_direction.normalized() * cur_speed * (delta * 100)
	else:
		velocity = direction.normalized() * cur_speed * (delta * 100)
	move_and_slide()

func anim_player(direction):
	if direction == Vector2.ZERO:
		$PlayerVisual/player_sprite_tree["parameters/conditions/Idle"] = true
		$PlayerVisual/player_sprite_tree["parameters/conditions/Walk"] = false
		$PlayerVisual/plate_armor_feet_tree["parameters/conditions/Idle"] = true
		$PlayerVisual/plate_armor_feet_tree["parameters/conditions/Walk"] = false
		$PlayerVisual/plate_armor_legs_tree["parameters/conditions/Idle"] = true
		$PlayerVisual/plate_armor_legs_tree["parameters/conditions/Walk"] = false
		$PlayerVisual/plate_armor_head_tree["parameters/conditions/Idle"] = true
		$PlayerVisual/plate_armor_head_tree["parameters/conditions/Walk"] = false
		$PlayerVisual/plate_armor_shoulders_tree["parameters/conditions/Idle"] = true
		$PlayerVisual/plate_armor_shoulders_tree["parameters/conditions/Walk"] = false
		$PlayerVisual/plate_armor_torso_tree["parameters/conditions/Idle"] = true
		$PlayerVisual/plate_armor_torso_tree["parameters/conditions/Walk"] = false
		$PlayerVisual/plate_armor_hands_tree["parameters/conditions/Idle"] = true
		$PlayerVisual/plate_armor_hands_tree["parameters/conditions/Walk"] = false
	else:
		$PlayerVisual/player_sprite_tree["parameters/conditions/Idle"] = false
		$PlayerVisual/player_sprite_tree["parameters/conditions/Walk"] = true
		$PlayerVisual/plate_armor_feet_tree["parameters/conditions/Idle"] = false
		$PlayerVisual/plate_armor_feet_tree["parameters/conditions/Walk"] = true
		$PlayerVisual/plate_armor_legs_tree["parameters/conditions/Idle"] = false
		$PlayerVisual/plate_armor_legs_tree["parameters/conditions/Walk"] = true
		$PlayerVisual/plate_armor_head_tree["parameters/conditions/Idle"] = false
		$PlayerVisual/plate_armor_head_tree["parameters/conditions/Walk"] = true
		$PlayerVisual/plate_armor_shoulders_tree["parameters/conditions/Idle"] = false
		$PlayerVisual/plate_armor_shoulders_tree["parameters/conditions/Walk"] = true
		$PlayerVisual/plate_armor_torso_tree["parameters/conditions/Idle"] = false
		$PlayerVisual/plate_armor_torso_tree["parameters/conditions/Walk"] = true
		$PlayerVisual/plate_armor_hands_tree["parameters/conditions/Idle"] = false
		$PlayerVisual/plate_armor_hands_tree["parameters/conditions/Walk"] = true
		$PlayerVisual/player_sprite_tree.set("parameters/Idle/blend_position", direction)
		$PlayerVisual/player_sprite_tree.set("parameters/Walk/blend_position", direction)
		$PlayerVisual/plate_armor_feet_tree.set("parameters/Idle/blend_position", direction)
		$PlayerVisual/plate_armor_feet_tree.set("parameters/Walk/blend_position", direction)
		$PlayerVisual/plate_armor_legs_tree.set("parameters/Idle/blend_position", direction)
		$PlayerVisual/plate_armor_legs_tree.set("parameters/Walk/blend_position", direction)
		$PlayerVisual/plate_armor_head_tree.set("parameters/Idle/blend_position", direction)
		$PlayerVisual/plate_armor_head_tree.set("parameters/Walk/blend_position", direction)
		$PlayerVisual/plate_armor_shoulders_tree.set("parameters/Idle/blend_position", direction)
		$PlayerVisual/plate_armor_shoulders_tree.set("parameters/Walk/blend_position", direction)
		$PlayerVisual/plate_armor_torso_tree.set("parameters/Idle/blend_position", direction)
		$PlayerVisual/plate_armor_torso_tree.set("parameters/Walk/blend_position", direction)
		$PlayerVisual/plate_armor_hands_tree.set("parameters/Idle/blend_position", direction)
		$PlayerVisual/plate_armor_hands_tree.set("parameters/Walk/blend_position", direction)

func add_item(rarity):
	var new_object = Modifier_class.new()
	new_object.Stats["rarity"] = rarity
	if (rarity == "sword_common"):
		new_object.Stats["texture"] = "res://world/assets/weapons/swords/sword_common.png"
		new_object.Stats["damage"] = 1
	if (rarity == "sword_uncommon"):
		new_object.Stats["texture"] = "res://world/assets/weapons/swords/sword_uncommon.png"
		new_object.Stats["damage"] = 3
	if (rarity == "sword_rare"):
		new_object.Stats["texture"] = "res://world/assets/weapons/swords/sword_rare.png"
		new_object.Stats["damage"] = 6
	if (rarity == "sword_epic"):
		new_object.Stats["texture"] = "res://world/assets/weapons/swords/sword_epic.png"
		new_object.Stats["damage"] = 12
	if (rarity == "sword_legendary"):
		new_object.Stats["texture"] = "res://world/assets/weapons/swords/sword_legendary.png"
		new_object.Stats["damage"] = 20
	if (rarity == "sword_mythical"):
		new_object.Stats["texture"] = "res://world/assets/weapons/swords/sword_mythical.png"
		new_object.Stats["damage"] = 30
	inventory.append(new_object)

func equip_item(item):
	if item.Stats["rarity"].contains("sword"):
		for i in inventory:
			if i == item:
				equiped_sword = i
				sword_sprite.set_texture(load(item.Stats["texture"]))

func show_inventory():
	for i in range (len(inventory)):
		inventory_buttons[i].set_button_icon(load(inventory[i].Stats["texture"]))
	for i in range (inventory_size):
		if i > len(inventory):
			inventory_buttons[i].icon = null
	$Inventory_UI.visible = true
	
func hide_inventory():
	$Inventory_UI.visible = false

func _on_slot_1_pressed():
	var cp = 0
	if (len(inventory) > cp + 1):
		#inventory.remove_at(cp)
		equip_item(inventory[cp])
	show_inventory()


func _on_slot_2_pressed():
	var cp = 1
	if (len(inventory) > cp + 1):
		equip_item(inventory[cp])
	show_inventory()


func _on_slot_3_pressed():
	var cp = 2
	if (len(inventory) > cp + 1):
		equip_item(inventory[cp])
	show_inventory()


func _on_slot_4_pressed():
	var cp = 3
	if (len(inventory) > cp + 1):
		equip_item(inventory[cp])
	show_inventory()


func _on_slot_5_pressed():
	var cp = 4
	if (len(inventory) > cp + 1):
		equip_item(inventory[cp])
	show_inventory()


func _on_slot_6_pressed():
	var cp = 5
	if (len(inventory) > cp + 1):
		equip_item(inventory[cp])
	show_inventory()


func _on_slot_7_pressed():
	var cp = 6
	if (len(inventory) > cp + 1):
		equip_item(inventory[cp])
	show_inventory()


func _on_slot_8_pressed():
	var cp = 7
	if (len(inventory) > cp + 1):
		equip_item(inventory[cp])
	show_inventory()


func _on_slot_9_pressed():
	var cp = 8
	if (len(inventory) > cp + 1):
		equip_item(inventory[cp])
	show_inventory()


func _on_slot_10_pressed():
	var cp = 9
	if (len(inventory) > cp + 1):
		equip_item(inventory[cp])
	
