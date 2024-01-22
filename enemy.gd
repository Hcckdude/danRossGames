extends RigidBody2D

signal hit

var motion = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	print('ENEMYS ')
	var enemy_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(enemy_types[randi() % enemy_types.size()])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var Player = get_parent().get_node("Player")
	look_at(Player.position)
	
	move_and_collide(motion)
	
	
#func _on_visible_on_screen_notifier_2d_screen_exited():
	##queue_free()
	
#green icon indicates signal is connected to this fn 



#func _on_hit_box_body_entered(body):
	#if "lightningBolt" in body.name:
		#queue_free()
		#hide() # Player disappears after being hit.
		#hit.emit()
		# Must be deferred as we can't change physics properties on a physics callback.
		#$CollisionShape2D.set_deferred("disabled", true)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_hit_box_body_entered(body):
	print('body entered = ', body.name)
	queue_free()
