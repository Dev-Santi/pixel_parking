extends CharacterBody2D

var looking_at:Vector2
var inverse_looking_at:Vector2
var can_move = true
var can_move_forward = true
var can_move_backward = true

func _ready():
	var car_name = self.get_name()
	if car_name.contains("left"):
		looking_at = Vector2(-8,0)
		inverse_looking_at = Vector2(8,0)
	elif car_name.contains("right"):
		looking_at = Vector2(8,0)
		inverse_looking_at = Vector2(-8,0)
	elif car_name.contains("top"):
		looking_at = Vector2(0,-8)
		inverse_looking_at = Vector2(0,8)
	elif car_name.contains("down"):
		looking_at = Vector2(0,8)
		inverse_looking_at = Vector2(0,-8)
	
	
func _process(_delta):
	if Globals.you_win:
		return null
		
	var is_selected:bool = Globals.car_selected == self
	var want_to_move_forward:bool = Input.is_action_pressed("forward")
	var want_to_move_backward:bool = Input.is_action_pressed("backward")
	
	#Le ponemos colorcito claro si esta selecionado
	if is_selected:
		modulate = Color("#ff89a2")
	else:
		modulate = Color("ffffff")
	
	#Si la pieza está seleccionada, puede moverse y desea hacerlo:
	if want_to_move_forward and is_selected and can_move and can_move_forward :
		move_and_collide(looking_at)
		can_move = false
		$MoveDelay.start()
	if want_to_move_backward and is_selected and can_move and can_move_backward:
		move_and_collide(inverse_looking_at)
		can_move = false
		$MoveDelay.start()

func _on_move_delay_timeout():
	can_move = true

#Si hacemos click con el boton primario del raton dentro del auto, seleccionarlo
func _on_click_detector_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		Globals.car_selected = self

#Limitamos el movimiento dependiendo de si tiene un objeto en el camino
func _on_front_car_detector_body_entered(body):
	if body != self:
		can_move_forward = false
func _on_back_car_detector_body_entered(body):
	if body != self:
		can_move_backward = false

func _on_front_car_detector_body_exited(body):
	if body != self:
		can_move_forward = true
func _on_back_car_detector_body_exited(body):
	if body != self:
		can_move_backward = true
