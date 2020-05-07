extends VBoxContainer

export(NodePath) var viewport_container_path
onready var viewport_container: ViewportContainer = get_node(viewport_container_path)
export(Material) var palette_material

func set_apply_palette(apply: bool):
	if apply:
		viewport_container.material = palette_material
	else:
		viewport_container.material = null
