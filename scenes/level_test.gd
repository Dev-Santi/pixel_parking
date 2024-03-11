extends Node2D


func _process(_delta):
	pass
	#if Input.is_action_just_pressed("forward"):
		#print("forward")
	#if Input.is_action_just_pressed("backward"):
		#print("backward")


func _on_finish_line_body_entered(_body):
	Globals.you_win = true
	$BoxContainer.visible = true


func _on_restart_pressed():
	get_tree().reload_current_scene()
