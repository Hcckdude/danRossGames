extends CharacterBody2D

const ACCELERATION = 500
const MAX_SPEED = 100
const ROLL_SPEED = 200
const FRICTION = 500

const lazer = preload("res://Lazer.tscn")

enum {
	MOVE,
	ROLL,
	}


var state = MOVE

var roll_vector = Vector2.LEFT
var KeyHeld = false
var right = false;
var left = false;
var up = false;
var down = false;


@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _physics_process(delta):
	var velocity = Vector2.ZERO
	match state:
		MOVE:
			move_state(delta)
			
		ROLL:
			roll_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if Input.is_action_pressed("ui_right"):
		right = true
		left = false
		up = false
		down = false
	
	elif Input.is_action_pressed("ui_left"):
		right = false
		left = true
		up = false
		down = false

	elif Input.is_action_pressed("ui_up"):
		right = false
		left = false
		up = true
		down = false
		
	elif Input.is_action_pressed("ui_down"):
		right = false
		left = false
		up = false
		down = true
		
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationTree.set("parameters/Aim/blend_position", input_vector)
		animationTree.set("parameters/Shoot/blend_position", input_vector)
		animationState.travel("Walk")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
	elif Input.is_action_pressed("aim"):
		
		animationState.travel("Aim")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
		
		if Input.is_action_just_pressed("shoot"):
			var Lazer = lazer.instantiate()
			print('lazer = ', Lazer)
			#if sign($Position2D.postion.x) == 1:
				#Lazer.set_lazer_direction(1)
			#else:
				#Lazer.set_lazer_direction(-1)
			
			get_parent().add_child(Lazer)
			
			if right:
	
				Lazer.position = $Node2D/Position2D4.global_position
				Lazer.set_lazer_direction(1)
				
			elif left:
			
				Lazer.position = $Node2D/Position2D3.global_position
				Lazer.set_lazer_direction(-1)
				
			elif down:
				
				Lazer.position = $Node2D/Position2D2.global_position
				Lazer.set_lazer_direction(1.1)
			
			elif up:
			
				Lazer.position = $Node2D/Marker2D.global_position
				Lazer.set_lazer_direction(-1.1)
				
			

			animationState.travel("Shoot")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			
		
		

	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move()
		
	if Input.is_action_just_pressed("roll"):
		state = ROLL

	

func roll_state(delta):
	velocity = roll_vector * ROLL_SPEED * 2
	animationState.travel("Roll")
	move()
		
func move():
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity

func roll_animation_finished():
	state = MOVE
