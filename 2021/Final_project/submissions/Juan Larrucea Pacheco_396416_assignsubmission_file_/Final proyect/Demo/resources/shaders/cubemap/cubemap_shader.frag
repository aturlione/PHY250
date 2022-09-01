#version 440

out vec4 FragColor;

in vec3 local_pos;
uniform samplerCube environment_map;

void main()
{
	vec3 environment_color = texture(environment_map, local_pos).rgb;
	
	environment_color = environment_color/(environment_color + vec3(1.f));
	
	environment_color = pow(environment_color, vec3(1.f/2.2f));
	
	FragColor = vec4(environment_color,1.f);
}