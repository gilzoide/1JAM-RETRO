extends Control

export(Color) var background_color = Color(0.25, 0.25, 0.25)
export(Color) var glow_color = Color(1.0, 1.0, 1.0)
export(float) var glow_size = 4
var points: PoolVector2Array

func _draw():
	var side = min(rect_size.x, rect_size.y)
	var half_size = side * 0.5
	var center = rect_pivot_offset
	draw_circle(center, ceil(half_size), background_color)
	
	var inset_radius = (side - glow_size) * 0.5
	for p in points:
		draw_circle(center + (p.clamped(1.0) * inset_radius), glow_size, glow_color)

func set_points(points: PoolVector2Array):
	self.points = points
	update()
