extends Area2D

const SPEED = 800
var velocity = Vector2()
var direction = 1

@onready var myLazer = get_node("AnimatedSprite2D")

#var bullet = $AnimatableBody2D

func _ready():
#	myLazer.set_name('bullet')
	pass
	
func set_lazer_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite2D.flip_h = false
	elif direction == - 1.1:
		$AnimatedSprite2D.rotation_degrees = -90
		$AnimatedSprite2D.flip_h = false
		
	elif direction == 1.1:
		$AnimatedSprite2D.rotation_degrees = 90
		$AnimatedSprite2D.flip_h = false
		
	
func _physics_process(delta):
	if direction == 1 :
		velocity.x = SPEED * delta * direction
	elif direction == -1:
		velocity.x = SPEED * delta * direction
	elif direction == - 1.1:
		$AnimatedSprite2D.rotation_degrees = 90
		velocity.y = SPEED * delta * direction
	elif direction == 1.1:
		$AnimatedSprite2D.rotation_degrees = -90
		velocity.y = SPEED * delta * direction

	#velocity.x = SPEED * delta
	translate(velocity)
	$AnimatedSprite2D.play("Lazer")

func launch(direction):
	var temp = global_position
#	print("direction = ",direction)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_hit_box_body_entered(body):
	queue_free()
	if body.name == 'Enemy':
		print('LAZER ON HIT = =  =', body.name)
	pass # Replace with function body.
