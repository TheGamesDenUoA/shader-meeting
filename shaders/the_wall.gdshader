shader_type spatial;
render_mode cull_disabled;

varying vec3 color;
varying vec3 position;

#include "noise.gdshaderinc"

void vertex() {
	color = vec3(0.0);
	float random = shell_worley_color(VERTEX + vec3(TIME*.1), 5., color);
	VERTEX.z -= random * 0.75;
	position = VERTEX;
}

void fragment() {
	float cloud = fbm(position + TIME * .1);
	ALBEDO.rgb = color;
	if (cloud > 0.1) {
		discard;
	}
}