shader_type spatial;

render_mode unshaded;

void fragment() {
	float time_modulation = 1.0 - abs(sin(TIME));
	ALBEDO = vec3(time_modulation);
}