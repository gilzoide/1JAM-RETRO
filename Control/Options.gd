extends VBoxContainer

export(NodePath) var root_container_path
onready var root_container: ViewportContainer = get_node(root_container_path)
export(Material) var palette_material

func set_apply_palette(apply: bool):
	root_container.material = palette_material if apply else null


func _on_LightRange_value_changed(value: float):
	var event = InputEventAction.new()
	event.action = "set_light_range"
	event.pressed = true
	event.strength = value
	Input.parse_input_event(event)
