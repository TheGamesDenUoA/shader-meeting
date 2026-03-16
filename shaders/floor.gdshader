shader_type spatial;

void vertex() {
}

void fragment() {
	float d = distance(VERTEX, vec3(0.0));
	float wave = (sin(d + TIME) + 1.0) / 2.0;
	ALBEDO = vec3(wave);
}

