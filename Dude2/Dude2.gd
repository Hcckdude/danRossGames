extends CharacterBody2D

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

const ACCELERATION = 500
const SPEED = 300.0
const MAX_SPEED = 100
const ROLL_SPEED = 200
const FRICTION = 500

const lazer = preload("res://Lazer.tscn")

enum {
	MOVE,
	ROLL,
	SHOOT,
	}


var state = MOVE
var input_vector = Vector2.ZERO
var roll_vector = Vector2.LEFT
var shoot_vector = Vector2.LEFT
var canShoot = true
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
#	print('sreen size = = = ', screen_size)
	animationTree.active = true

func _physics_process(delta):
	var velocity = Vector2.ZERO
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		SHOOT:
			shoot_state(delta)

func move_state(delta):
	input_vector = Input.get_vector( "move_left","move_right", "move_up", "move_down")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationState.travel("Walk")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		velocity = input_vector * SPEED
		
		if Input.is_action_just_pressed("roll"):
			state = ROLL
		else:
			state = MOVE

	if Input.is_action_pressed("aim"):
		state = SHOOT
	
	if input_vector == Vector2.ZERO:
		velocity = Vector2.ZERO
		animationState.travel("Idle")
	
	move_and_slide()
		

func roll_state(delta):
	velocity = roll_vector * ROLL_SPEED * 2
	animationTree.set("parameters/Roll/blend_position", input_vector)
	animationState.travel("Roll")
	move()

func shoot_state(delta):
	velocity = Vector2.ZERO
	input_vector = Input.get_vector( "move_left","move_right", "move_up", "move_down")
	animationTree.set('parameters/Aim/blend_position', input_vector)
	animationState.travel("Aim")

	if Input.is_action_just_pressed("shoot") && canShoot:
		var Lazer = lazer.instantiate()
		get_parent().add_child(Lazer)
		animationTree.set('parameters/Shoot/blend_position', input_vector)
		if Input.is_action_pressed("move_right"):
			Lazer.position = $Node2D/Position2D4.global_position               
			Lazer.set_lazer_direction(1)
			shoot()
		elif Input.is_action_pressed("move_left"):
			Lazer.position = $Node2D/Position2D3.global_position
			Lazer.set_lazer_direction(-1)
			shoot()
		elif Input.is_action_pressed("move_down"):
			Lazer.position = $Node2D/Position2D2.global_position
			Lazer.set_lazer_direction(1.1)
			shoot()
		elif Input.is_action_pressed("move_up"):
			Lazer.position = $Node2D/Marker2D.global_position
			Lazer.set_lazer_direction(-1.1)
			shoot()
	if Input.is_action_just_released("aim"):
		velocity = Vector2.ZERO
		state = MOVE
	move()
	pass
	
func shoot():
	velocity = Vector2.ZERO
	animationState.travel("Shoot")
	canShoot = false

func move():
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity

func _on_animation_tree_animation_finished(anim_name):
#	print('2 finsihed animation = = = = ', anim_name)
	if anim_name == 'RollRight': 
		state = MOVE
	if anim_name == 'RollLeft':
		state = MOVE
	if anim_name == 'RollUp':
		state = MOVE
	if anim_name == 'RollDown':
		state = MOVE
	if anim_name == 'ShootLeft':
		canShoot = true
	if anim_name == 'ShootRight':
		canShoot = true
	if anim_name == 'ShootUp':
		canShoot = true
	if anim_name == 'ShootDown':
		canShoot = true

