extends KinematicBody

export(float) var linear_speed = 5
export(float) var angular_speed = deg2rad(60)
var is_moving = false

onready var animationPlayer = $AnimationPlayer
onready var spotlight: SpotLight = $SpotLight
onready var spotlight_full_range: float = spotlight.spot_range

func _process(delta):
	var rotation = 0
	if Input.is_action_pressed("camera_rotate_left"):
		rotation += angular_speed
	if Input.is_action_pressed("camera_rotate_right"):
		rotation -= angular_speed
	rotate_object_local(Vector3.UP, rotation * delta)
	
	if is_moving and not animationPlayer.is_playing():
		animationPlayer.play("PlayerLinearMove")
	
	if Input.is_action_pressed("set_light_range"):
		set_light_range(Input.get_action_strength("set_light_range"))

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
	var speed = move_and_slide(movement * linear_speed)
	is_moving = speed.length_squared() > 0

func stop_movement_animation():
	if not is_moving:
		animationPlayer.stop()

func set_light_range(amount: float):
	spotlight.spot_range = amount * spotlight_full_range
