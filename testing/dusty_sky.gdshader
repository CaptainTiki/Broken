shader_type spatial;
render_mode unshaded, cull_disabled, depth_draw_never;

uniform vec4 horizon_color : source_color = vec4(0.76, 0.56, 0.22, 1.0);
uniform vec4 zenith_color : source_color = vec4(0.31, 0.20, 0.12, 1.0);
uniform vec4 dust_color : source_color = vec4(0.93, 0.72, 0.31, 1.0);

float hash(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

float noise(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);
	vec2 u = f * f * (3.0 - 2.0 * f);
	return mix(
		mix(hash(i), hash(i + vec2(1.0, 0.0)), u.x),
		mix(hash(i + vec2(0.0, 1.0)), hash(i + vec2(1.0, 1.0)), u.x),
		u.y
	);
}

void fragment() {
	float vertical = clamp(UV.y, 0.0, 1.0);
	vec3 sky = mix(horizon_color.rgb, zenith_color.rgb, smoothstep(0.0, 1.0, vertical));
	float low_dust = 1.0 - smoothstep(0.18, 0.72, vertical);
	float grit = noise(UV * vec2(11.0, 4.0)) * 0.18 + noise(UV * vec2(34.0, 8.0)) * 0.08;
	ALBEDO = mix(sky, dust_color.rgb, clamp(low_dust * 0.58 + grit, 0.0, 0.72));
	ALPHA = 1.0;
}
