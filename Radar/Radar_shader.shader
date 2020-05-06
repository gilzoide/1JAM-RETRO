shader_type spatial;

render_mode unshaded;

uniform sampler2D pallete;

const float DISTANCE_FACTOR = 1.0 / 2.0;
const float DISTANCE_BIAS = 2.0;
const float TEXTURE_WIDTH = 4.0; // assume texture have only 4 pixels
const float NEAR_EDGE_MIN = 0.002;
const float NEAR_EDGE_MAX = 0.998;

varying vec3 position_from_camera;

float snap_uvx(float uvx) {
	return round(uvx) / (TEXTURE_WIDTH - 1.0);
}

void vertex() {
	vec4 position = MODELVIEW_MATRIX * vec4(VERTEX, 1);
	position_from_camera = position.xyz;
	POSITION = PROJECTION_MATRIX * position;
}

void fragment() {
	bool near_edge = UV.x <= NEAR_EDGE_MIN || UV.x >= NEAR_EDGE_MAX || UV.y <= NEAR_EDGE_MIN || UV.y >= NEAR_EDGE_MAX;
	float near_edge_bias = float(near_edge) * TEXTURE_WIDTH;
	
	float distance_to_camera = length(position_from_camera);
	
	float uvx = (distance_to_camera - DISTANCE_BIAS + near_edge_bias) * DISTANCE_FACTOR;
	vec4 tex = texture(pallete, vec2(snap_uvx(uvx), 0));
	ALBEDO = tex.rgb;
}
