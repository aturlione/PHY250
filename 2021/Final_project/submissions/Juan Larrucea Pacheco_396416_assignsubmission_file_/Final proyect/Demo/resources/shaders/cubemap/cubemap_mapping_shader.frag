#version 440

in vec3 local_pos;
out vec4 FragColor;

uniform sampler2D equirectangular_map;

const vec2 invAtan = vec2(0.1591, 0.3183);
vec2 SampleSphericalMap(vec3 v)
{
    vec2 uv = vec2(atan(v.z, v.x), asin(v.y));
    uv *= invAtan;
    uv += 0.5;
    return uv;
}

void main()
{
	vec2 uvs = SampleSphericalMap(normalize(local_pos));
	FragColor = vec4(texture(equirectangular_map, uvs).rgb,1.f);
}