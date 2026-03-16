shader_type spatial;

uniform sampler2D albedo_tex : source_color;
uniform sampler2D normal_tex;

void vertex() {

}

void fragment() {
	vec3 albedo = texture(albedo_tex, UV).rgb;
	vec3 normal = texture(normal_tex, UV).xyz;
	ALBEDO.rgb = albedo;
	NORMAL = normal;
}
