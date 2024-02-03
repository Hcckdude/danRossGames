extends CanvasLayer

signal start_game

var startedGame = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed(&"start_game"):
		_on_start_with_controller(startedGame)
		startedGame = true
#	pass







func show_message(text):
#	$Message.text = text
#	$Message.show()
#	$MessageTimer.start()
	pass
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Dodge the 
	 Creeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	startedGame = false;
	$StartButton.show()	
	
func update_score(score):
#	$ScoreLabel.text = str(score)	
	pass
	
	
	
func _on_start_with_controller(startedGame):
	if !startedGame:
#		print('start game', startedGame)
		#$StartButton.hide()
#		start_game.emit()
		pass
		
	
			
	


func _on_start_game():
#	print('start game')
#	$StartButton.hide()
	start_game.emit()


func _on_start_button_pressed():
#	print('start button pressed')
	$StartButton.hide()
	start_game.emit()
