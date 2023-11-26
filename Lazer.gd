extends Area2D

const SPEED = 800
var velocity = Vector2()
var direction = 1


func _ready():
	pass
	
func set_lazer_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
	elif dir == -1.1:
		$AnimatedSprite.flip_v = true
	
	
func _physics_process(delta):
	if direction == 1 :
		print("1 direction verticle", direction)
		velocity.x = SPEED * delta * direction
	elif direction == -1:
		print("2 direction verticle", direction)
		velocity.x = SPEED * delta * direction
	elif direction == - 1.1:
		print("3 direction verticle", direction)
		velocity.y = SPEED * delta * direction
	elif direction == 1.1:
		velocity.y = SPEED * delta * direction
		print("4 direction verticle", direction)
		
	#velocity.x = SPEED * delta
	translate(velocity)
	$AnimatedSprite.play("Lazer")

func launch(direction):
	var temp = global_position
	print("direction = ",direction)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
