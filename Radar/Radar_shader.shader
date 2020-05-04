shader_type spatial;

render_mode unshaded;

uniform sampler2D pallete;

const float distanceFactor = 1.0 / 2.0;
const float distanceBias = 2.0;
const float textureWidth = 4.0; // assume texture have only 4 pixels

varying float distanceToCamera;

void vertex() {
	vec4 position = MODELVIEW_MATRIX * vec4(VERTEX, 1);
	distanceToCamera = -position.z;
	POSITION = PROJECTION_MATRIX * position;
}

void fragment() {
	float uvx = (distanceToCamera - distanceBias) * distanceFactor;
	uvx = round(uvx) / (textureWidth - 1.0);
	vec4 tex = texture(pallete, vec2(uvx, 0));
	ALBEDO = tex.rgb;
}
