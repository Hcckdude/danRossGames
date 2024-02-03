extends RigidBody2D

signal hit

var motion = Vector2()
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	var enemy_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(enemy_types[randi() % enemy_types.size()])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var velocity = Vector2.ZERO
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	var Player = get_parent().get_node("Player")
	look_at(Player.position)
	
	move_and_collide(motion)
	


func _on_hit_box_body_entered(body):
	var n = body.name
	if n == 'Box':
		print('body entered = ', n)
#	queue_free()
#	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
