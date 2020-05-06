shader_type canvas_item;

render_mode unshaded;

uniform sampler2D palette;

const float PALETTE_WIDTH = 4.0;

vec4 snap_to_palette(float x) {
	x = 1.0 - x;
	x = round(x * PALETTE_WIDTH) / (PALETTE_WIDTH - 1.0);
	return texture(palette, vec2(x, 0.0));
}

void fragment() {
	float x = texture(TEXTURE, SCREEN_UV).x;
	//COLOR = vec4(x, x, x, 1.0);
	COLOR = snap_to_palette(x);
}
