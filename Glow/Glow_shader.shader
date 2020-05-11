shader_type spatial;

render_mode unshaded;

void fragment() {
	float time_modulation = abs(sin(TIME));
	ALBEDO = vec3(time_modulation);
}