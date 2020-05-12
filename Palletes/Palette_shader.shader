shader_type canvas_item;

render_mode unshaded;

uniform sampler2D palette;

const float PALETTE_WIDTH = 4.0;

vec4 snap_to_palette(float x) {
	x = clamp(x, 0.0, 1.0);
	x = round(x * PALETTE_WIDTH) * (1.0 / PALETTE_WIDTH);
	return texture(palette, vec2(x, 0.0));
}

void fragment() {
	vec4 pixel = texture(TEXTURE, UV);
	COLOR = snap_to_palette(pixel.r);
}
