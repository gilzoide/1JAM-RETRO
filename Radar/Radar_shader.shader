shader_type spatial;

render_mode unshaded;

const float DISTANCE_FACTOR = 1.0 / 2.0;
const float DISTANCE_BIAS = 2.0;
const float DISTANCE_DARK = 3.0;
const float NEAR_EDGE_MIN = 0.002;
const float NEAR_EDGE_MAX = 0.998;

varying vec3 position_from_camera;

void vertex() {
	vec4 position = MODELVIEW_MATRIX * vec4(VERTEX, 1);
	position_from_camera = position.xyz;
	POSITION = PROJECTION_MATRIX * position;
}

void fragment() {
	bool near_edge = UV.x <= NEAR_EDGE_MIN || UV.x >= NEAR_EDGE_MAX || UV.y <= NEAR_EDGE_MIN || UV.y >= NEAR_EDGE_MAX;
	float near_edge_bias = float(near_edge) * (DISTANCE_DARK + 1.0);
	
	float distance_to_camera = length(position_from_camera);
	
	float dist = (distance_to_camera - DISTANCE_BIAS + near_edge_bias) * DISTANCE_FACTOR;
	float r = 1.0 - (dist / DISTANCE_DARK);
	ALBEDO = vec3(r);
}
