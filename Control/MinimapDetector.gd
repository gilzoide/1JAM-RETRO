extends Area

export(NodePath) var minimap_path
onready var minimap = get_node(minimap_path)
onready var radius = $CollisionShape.shape.radius
onready var inverse_radius = 1.0 / radius

var bodies = {}

func _ready():
	set_process(false)

func _process(delta):
	var points = PoolVector2Array()
	for b in bodies:
		var body_position = b.global_transform.origin
		var relative_body_position = to_local(body_position)
		var point = relative_body_position * inverse_radius
		points.append(Vector2(point.x, point.z))
	minimap.set_points(points)

func _on_body_entered(body):
	bodies[body] = true
	set_process(true)

func _on_body_exited(body):
	bodies.erase(body)
	if bodies.empty():
		minimap.set_points(PoolVector2Array())
		set_process(false)
