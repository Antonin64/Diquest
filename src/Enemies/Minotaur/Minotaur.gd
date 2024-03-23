extends CharacterBody2D

const DAMAGE = 10
const SPEED = 120
const ATTACK_RANGE = 50
const AGRO_RANGE = 300
const BASE_HP = 5

var target_location
var direction : Vector2 = Vector2.ZERO
var attack : bool = false
var agro
var hp
var player_node

@onready var navigation_agent := $NavigationAgent2D as NavigationAgent2D
@onready var animation_tree = $AnimationTree

func _ready():
	agro = false
	hp = BASE_HP

func _physics_process(_delta):
	if agro:
		direction = to_local(navigation_agent.get_next_path_position()).normalized()
	if not attack and agro:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _process(_delta):
	if hp <= 0:
		set_death(true)
	
	if global_position.distance_to(player_node.global_position) < AGRO_RANGE:
		agro = true
	
	if global_position.distance_to(player_node.global_position) < ATTACK_RANGE and not attack:
		set_attack(true)
	
	if not attack and agro:
		set_walking(true)
		update_blend_position()
	else:
		set_walking(false)

func set_attack(value = false):
	attack = value
	animation_tree["parameters/conditions/big_attack"] = value

func set_death(value):
	animation_tree["parameters/conditions/death"] = value

func set_walking(value):
	animation_tree["parameters/conditions/is_walking"] = value
	animation_tree["parameters/conditions/idle"] = not value

func update_blend_position():
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
	if anim_name == "Death":
		free()

func create_path():
	navigation_agent.target_position = player_node.global_position

func _on_timer_timeout():
	create_path()
