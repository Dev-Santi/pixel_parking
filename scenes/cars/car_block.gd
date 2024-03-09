extends CharacterBody2D

var can_move = true
var can_move_top = true
var can_move_bottom = true

func _process(_delta):
	var is_selected:bool = Globals.car_selected == self
	var want_to_move_top:bool = Input.is_action_pressed("up")
	var want_to_move_bottom:bool = Input.is_action_pressed("down")
	
	#Le ponemos colorcito claro si esta selecionado
	if is_selected:
		modulate = Color("#cacaca")
	else:
		modulate = Color("ffffff")
	
	#Si la pieza está seleccionada, puede moverse y desea hacerlo:
	if want_to_move_top and is_selected and can_move and can_move_top:
		move_and_collide(Vector2(0,-8))
		can_move = false
		$MoveDelay.start()
	if want_to_move_bottom and is_selected and can_move and can_move_bottom:
		move_and_collide(Vector2(0,8))
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
		can_move_top = false
func _on_back_car_detector_body_entered(body):
	if body != self:
		can_move_bottom = false

func _on_front_car_detector_body_exited(body):
	if body != self:
		can_move_top = true
func _on_back_car_detector_body_exited(body):
	if body != self:
		can_move_bottom = true
