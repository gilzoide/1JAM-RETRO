extends Area

export(NodePath) var minimap_path
onready var minimap = get_node(minimap_path)
onready var radius = $CollisionShape.shape.radius
onready var inverse_radius = 1.0 / radius

func _process(_delta):
	if minimap == null:
		return
	
	var points = PoolVector2Array()
	for b in get_overlapping_bodies():
		var body_position = b.global_transform.origin
		var relative_body_position = to_local(body_position)
		var point = relative_body_position * inverse_radius
		points.append(Vector2(point.x, point.z))
	minimap.update_points(points)
	minimap.update_rotation(global_transform.basis.get_euler().y)
