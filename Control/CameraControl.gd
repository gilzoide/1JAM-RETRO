extends Camera

export(float) var linear_speed = 5
export(float) var angular_speed = deg2rad(45)

func _process(delta):
	var movement = Vector3()
	if Input.is_action_pressed("camera_forward"):
		movement.z -= 1
	if Input.is_action_pressed("camera_back"):
		movement.z += 1
	if Input.is_action_pressed("camera_strafe_left"):
		movement.x -= 1
	if Input.is_action_pressed("camera_strafe_right"):
		movement.x += 1
	movement = movement.normalized()
	
	var rotation = 0
	if Input.is_action_pressed("camera_rotate_left"):
		rotation += angular_speed
	if Input.is_action_pressed("camera_rotate_right"):
		rotation -= angular_speed
	
	translate_object_local(movement * linear_speed * delta)
	rotate_object_local(Vector3.UP, rotation * delta)
