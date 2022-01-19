shader_type canvas_item;
render_mode blend_mix;

uniform float gradient_start = 0;
uniform float gradient_end = 1;
uniform vec4 light_color: hint_color = vec4(0.25, 0.0625, 0.25, 1.0);
uniform vec4 dark_color: hint_color = vec4(0.25, 0.0625, 0.25, 1.0);

void fragment(){
	float dark = min(1.0, max(0.0, (UV.y - gradient_start) / (gradient_end - gradient_start)));
		
	vec4 ambient_color = mix(light_color, dark_color, dark);
	
	// get screen color for this pixel
	vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	// apply multiply blend mode
	if (AT_LIGHT_PASS) {
		COLOR = screen_color
	} else {
		COLOR = screen_color * ambient_color;
	}
}