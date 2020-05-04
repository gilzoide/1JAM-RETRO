extends KinematicBody

export(float) var linear_speed = 5
export(float) var angular_speed = deg2rad(45)

func _process(delta):
	var rotation = 0
	if Input.is_action_pressed("camera_rotate_left"):
		rotation += angular_speed
	if Input.is_action_pressed("camera_rotate_right"):
		rotation -= angular_speed
	rotate_object_local(Vector3.UP, rotation * delta)

func _physics_process(_delta):
	var movement = Vector3()
	if Input.is_action_pressed("camera_forward"):
		movement += Vector3.FORWARD
	if Input.is_action_pressed("camera_back"):
		movement += Vector3.BACK
	if Input.is_action_pressed("camera_strafe_left"):
		movement += Vector3.LEFT
	if Input.is_action_pressed("camera_strafe_right"):
		movement += Vector3.RIGHT
	
	movement = movement.normalized().rotated(Vector3.UP, rotation.y)
# warning-ignore:return_value_discarded
	move_and_slide(movement * linear_speed)
	
