#version 440

const float PI = 3.14159265359;
const int MAX_LIGHTS = 8;

struct Material
{
	sampler2D color_map;
	sampler2D roughness_map;
	sampler2D metallic_map;
	sampler2D ao_map;
	sampler2D normal_map;
};

struct BasicMaterial
{
	vec4 color;
	float roughness;
	float metallic;
	float ao;
};

struct Light
{
	vec3 position;
	vec3 color;
};


out vec4 FragColor;

in vec3 pos_world;
in vec3 transformed_normal;
in vec2 uvs;

uniform Material material_to_use;
uniform BasicMaterial basic_material_to_use;
uniform int number_of_lights;
uniform Light lights[MAX_LIGHTS];
uniform vec3 camera_position;

uniform samplerCube irradiance_map;
uniform samplerCube prefilter_map;
uniform sampler2D lut_texture;

uniform int using_color_map;
uniform int using_metallic_map;
uniform int using_roughness_map;
uniform int using_ao_map;
uniform int using_normal_map;

vec3 getNormalFromMap()
{
    vec3 tangentNormal = texture(material_to_use.normal_map, uvs).xyz * 2.0 - 1.0;

    vec3 Q1  = dFdx(pos_world);
    vec3 Q2  = dFdy(pos_world);
    vec2 st1 = dFdx(uvs);
    vec2 st2 = dFdy(uvs);

    vec3 N   = normalize(transformed_normal);
    vec3 T  = normalize(Q1*st2.t - Q2*st1.t);
    vec3 B  = -normalize(cross(N, T));
    mat3 TBN = mat3(T, B, N);

    return normalize(TBN * tangentNormal);
}
//-----------------------------------------------------
float DistributionGGX(vec3 N, vec3 H, float roughness)
{
    float a = roughness*roughness;
    float a2 = a*a;
    float NdotH = max(dot(N, H), 0.0);
    float NdotH2 = NdotH*NdotH;

    float nom   = a2;
    float denom = (NdotH2 * (a2 - 1.0) + 1.0);
    denom = PI * denom * denom;

    return nom / denom;
}
// ----------------------------------------------------------------------------
float GeometrySchlickGGX(float NdotV, float roughness)
{
    float r = (roughness + 1.0);
    float k = (r*r) / 8.0;

    float nom   = NdotV;
    float denom = NdotV * (1.0 - k) + k;

    return nom / denom;
}
// ----------------------------------------------------------------------------
float GeometrySmith(vec3 N, vec3 V, vec3 L, float roughness)
{
    float NdotV = max(dot(N, V), 0.0);
    float NdotL = max(dot(N, L), 0.0);
    float ggx2 = GeometrySchlickGGX(NdotV, roughness);
    float ggx1 = GeometrySchlickGGX(NdotL, roughness);

    return ggx1 * ggx2;
}
// ----------------------------------------------------------------------------
vec3 fresnelSchlick(float cosTheta, vec3 F0)
{
    return F0 + (1.0 - F0) * pow(clamp(1.0 - cosTheta, 0.0, 1.0), 5.0);
}
// ----------------------------------------------------------------------------
vec3 fresnelSchlickRoughness(float cosTheta, vec3 F0, float roughness)
{
    return F0 + (max(vec3(1.0 - roughness), F0) - F0) * pow(clamp(1.0 - cosTheta, 0.0, 1.0), 5.0);
}   
// ----------------------------------------------------------------------------

void main()
{
	vec3 colors[2] = vec3[2](vec3(basic_material_to_use.color),pow(texture(material_to_use.color_map, uvs).rgb, vec3(2.2)) );
	float metallics[2] = float[2](basic_material_to_use.metallic,texture(material_to_use.metallic_map,uvs).r );
	float roughnesses[2] = float[2](basic_material_to_use.roughness,texture(material_to_use.roughness_map,uvs).r );
	float aos[2] = float[2](basic_material_to_use.ao,texture(material_to_use.ao_map,uvs).r );
	vec3 normals[2] = vec3[2](normalize(transformed_normal),getNormalFromMap() );
	
	vec3 color = colors[using_color_map];
	float metallic = metallics[using_metallic_map];
	float roughness = roughnesses[using_roughness_map];
	float ao = aos[using_ao_map];
	//vec3 normalized_normal = normals[using_normal_map];
	vec3 normalized_normal = normals[using_normal_map];
	
	vec3 view_vector = normalize(camera_position - pos_world);
	vec3 reflection = reflect(-view_vector,normalized_normal);
	
	vec3 F0 = vec3(0.04f); 
    F0 = mix(F0, color, metallic);
	
	vec3 Lo = vec3(0.0);
	
	for(int i = 0; i < number_of_lights; i++) 
    {
		vec3 L = normalize(lights[i].position - pos_world);
        vec3 H = normalize(view_vector + L);
		
		float distance = length(lights[i].position - pos_world);
        float attenuation = 1.0 / (distance * distance);
        vec3 radiance = lights[i].color * attenuation;
		
		float NDF = DistributionGGX(normalized_normal, H, roughness);   
        float G   = GeometrySmith(normalized_normal, view_vector, L, roughness);      
        vec3 F    = fresnelSchlick(max(dot(H, view_vector), 0.0), F0);
		
		vec3 numerator    = NDF * G * F; 
        float denominator = 4 * max(dot(normalized_normal, view_vector), 0.0) * max(dot(normalized_normal, L), 0.0) + 0.0001; // + 0.0001 to prevent divide by zero
        vec3 specular = numerator / denominator;
		
		vec3 kS = F;
        // for energy conservation, the diffuse and specular light can't
        // be above 1.0 (unless the surface emits light); to preserve this
        // relationship the diffuse component (kD) should equal 1.0 - kS.
        vec3 kD = vec3(1.0) - kS;
        // multiply kD by the inverse metalness such that only non-metals 
        // have diffuse lighting, or a linear blend if partly metal (pure metals
        // have no diffuse light).
        kD *= 1.0 - metallic;	  

        // scale light by NdotL
        float NdotL = max(dot(normalized_normal, L), 0.0);        

        // add to outgoing radiance Lo
        Lo += (kD * color / PI + specular) * radiance * NdotL;
	}
		
	vec3 F = fresnelSchlickRoughness(max(dot(normalized_normal, view_vector), 0.0), F0, roughness);
	
	vec3 kS = F;
    vec3 kD = 1.0 - kS;
    kD *= 1.0 - metallic;
	
    vec3 irradiance = texture(irradiance_map, normalized_normal).rgb;
    vec3 diffuse      = irradiance * color;
		
		
	const float MAX_REFLECTION_LOD = 4.0;
	vec3 prefilteredColor = textureLod(prefilter_map, reflection, roughness * MAX_REFLECTION_LOD).rgb;    
	vec2 brdf  = texture(lut_texture, vec2(max(dot(normalized_normal,view_vector), 0.0), roughness)).rg;
	vec3 specular = prefilteredColor * (F * brdf.x + brdf.y);	
	
	vec3 ambient = (kD * diffuse + specular) * ao;

    vec3 fin_color = ambient + Lo;

    // HDR tonemapping
    fin_color = fin_color / (fin_color + vec3(1.0));
    // gamma correct
    fin_color = pow(fin_color, vec3(1.0/2.2)); 
	
	
    FragColor = vec4(fin_color, 1.f);

}