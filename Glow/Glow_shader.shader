shader_type spatial;

render_mode unshaded;

uniform sampler2D pallete;

const float TEXTURE_WIDTH = 4.0; // assume texture have only 4 pixels
const float NEAR_EDGE_MIN = 0.005;
const float NEAR_EDGE_MAX = 0.995;

float snap_uvx(float uvx) {
	return (round(uvx * TEXTURE_WIDTH)) / (TEXTURE_WIDTH - 1.0);
}

void fragment() {
	bool near_edge = UV.x < NEAR_EDGE_MIN || UV.x > NEAR_EDGE_MAX || UV.y < NEAR_EDGE_MIN || UV.y > NEAR_EDGE_MAX;
	float near_edge_bias = float(near_edge);
	float time_modulation = 1.0 - abs(sin(TIME));
	float uvx = near_edge_bias + time_modulation;
	ALBEDO = texture(pallete, vec2(snap_uvx(uvx), 0.0)).rgb;
}