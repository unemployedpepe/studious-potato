extends CharacterBody2D

signal laser (pos, direction)
signal grenade (pos, direction)
var can_laser: bool = true 
var can_grenade: bool = true 

func _process(_delta):
	#Input 
	# starts  with negative x, positive x, negative y and positive y 
	var direction = Input.get_vector("move_left", "move_right", "move_up","move_down")
	velocity = direction * 500
	move_and_slide()
	look_at(get_global_mouse_position())
	
	var player_direction = (get_local_mouse_position() - position).normalized()
	if Input.is_action_pressed("Primary_action") and can_laser :
			#random marker to start 
		can_laser = false
		$Timer.start() 
		var laser_markers = $LaserStartPosition.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		laser.emit(selected_laser.global_position, player_direction)
		
		
	if Input.is_action_pressed("Secondary_action") and can_grenade :
		can_grenade = false 
		$Timer2.start()
		var pos = $LaserStartPosition.get_children()[0].global_position
		grenade.emit(pos, player_direction )


func _on_timer_timeout():
	can_laser = true 

func _on_timer_2_timeout():
	can_grenade = true 
	
	
	
	

