extends Control

export(Texture) var compass_point_tex
onready var compass_point_size = compass_point_tex.get_size()
onready var compass_point_margin = compass_point_size * 0.75
onready var compass_point_half_size = compass_point_size * 0.5
export(Color) var background_color = Color(0.25, 0.25, 0.25)
export(Color) var glow_color = Color(1.0, 1.0, 1.0)
export(float) var glow_size = 4

var points: PoolVector2Array
var rotation: float

func _draw():
	var side = min(rect_size.x, rect_size.y)
	var half_size = side * 0.5
	var center = rect_pivot_offset
	draw_circle(center, ceil(half_size), background_color)
	
	var inset_radius = (side - glow_size) * 0.5
	for p in points:
		draw_circle(center + (p.clamped(1.0) * inset_radius), glow_size, glow_color)
	var compass_point = Vector2(0, -1.1).rotated(rotation) * (inset_radius + compass_point_margin.y)
	draw_texture(compass_point_tex, center + compass_point - compass_point_half_size)

func set_points(detected_points: PoolVector2Array):
	points = detected_points
	update()

func set_rotation(detector_rotation: float):
	rotation = detector_rotation
	update()
