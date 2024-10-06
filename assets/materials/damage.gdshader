shader_type spatial;

uniform float time = 0.0;
uniform float alpha = 0.0;

uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
	float t = sin(0.5 * time) * 0.5 + 0.5;
	vec4 color = texture(screen_texture, SCREEN_UV);
	vec3 tint = mix(vec3(0.0, 0.0, 0.0), vec3(1.0, 0.0, 0.0), t * alpha);
	EMISSION = tint * 2.0;
}
