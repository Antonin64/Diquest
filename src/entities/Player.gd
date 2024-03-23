extends CharacterBody2D

#constant
const SPEED = 280.0
const JUMP_VELOCITY = -400.0
const DASH_SPEED = 1100
const DASH_DURATION = 0.01

#public var
@export var max_hp : int  = 100
@export var hp : int  = 100

@onready var dash = $Dash

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

##### combat #####

func apply_damage(amount : int):
	if (dash.is_dashing()):
		return
	hp -= amount
	
func die():
	if (hp <= 0):
		1
		#TODO die

##### ----- #####

#physic process
func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Input.is_action_pressed("dash"):
		dash.start_dash(DASH_DURATION)

#movement direction
	var cur_speed = DASH_SPEED if dash.is_dashing() else SPEED
	velocity = direction.normalized() * cur_speed * (delta * 100)
	move_and_slide()
