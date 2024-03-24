extends CharacterBody2D

const DAMAGE = 20
const SPEED = 120
const ATTACK_RANGE = 100
const AGRO_RANGE = 300
const BASE_HP = 200

var direction : Vector2 = Vector2.ZERO
var attack : int = 0
var agro
var hp
var player_node
var rng = RandomNumberGenerator.new()

@onready var navigation_agent = $NavigationAgent2D
@onready var animation_tree = $AnimationTree

func _ready():
	agro = false
	hp = BASE_HP

func _physics_process(_delta):
	if agro:
		direction = to_local(navigation_agent.get_next_path_position()).normalized()
	if attack == 0 and agro:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _process(_delta):
	if hp <= 0:
		set_death(true)
	
	if global_position.distance_to(player_node.global_position) < AGRO_RANGE:
		agro = true
	
	if attack == 0 and agro:
		set_walking(true)
		update_blend_position()
	
	if player_node != null:
		if global_position.distance_to(player_node.global_position) < ATTACK_RANGE and attack == 0:
			set_attack(rng.randi() % 3 + 1)

func set_attack(value = 0):
	if value != 0:
		attack = value
		animation_tree["parameters/conditions/is_walking"] = false
	if value == 1:
		animation_tree["parameters/conditions/big_attack"] = true
	if value == 2:
		animation_tree["parameters/conditions/quick_attack"] = true
	if value == 3:
		animation_tree["parameters/conditions/tourbi_lol"] = true
	if value == 0:
		animation_tree["parameters/conditions/big_attack"] = false
		animation_tree["parameters/conditions/quick_attack"] = false
		animation_tree["parameters/conditions/tourbi_lol"] = false

func set_death(value):
	player_node.earn_money(500)
	player_node.earn_xp(500)
	animation_tree["parameters/conditions/death"] = value

func set_walking(value):
	animation_tree["parameters/conditions/is_walking"] = value

func update_blend_position():
	animation_tree["parameters/Death/blend_position"] = direction
	animation_tree["parameters/Big_Attack/blend_position"] = direction
	animation_tree["parameters/Quick_attack/blend_position"] = direction
	animation_tree["parameters/Tourbi_lol/blend_position"] = direction
	animation_tree["parameters/Idle/blend_position"] = direction
	animation_tree["parameters/Walk/blend_position"] = direction

func take_damage(value):
	agro = true
	hp = hp - value

func handle_attack():
	$Area2D.rotation = direction.angle()
	$Area2D.position = direction * Vector2(30, 30)
	if $Area2D.overlaps_body(player_node):
		player_node.apply_damage(DAMAGE)
	$Area2D.position = Vector2(0, 0)

func _on_animation_tree_animation_finished(anim_name):
	if anim_name.contains("attack") or anim_name.contains("lol"):
		attack = 0
		animation_tree["parameters/conditions/is_walking"] = true
	if anim_name.begins_with("death"):
		queue_free()

func create_path():
	navigation_agent.target_position = player_node.global_position

func _on_timer_timeout():
	create_path()
