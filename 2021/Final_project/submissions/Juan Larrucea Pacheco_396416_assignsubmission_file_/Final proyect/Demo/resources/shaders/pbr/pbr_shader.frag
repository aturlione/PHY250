//This code will execute for every pixel of the object
//that is being drawn

#version 440

//Constants of the program
const float PI = 3.14159265359;
const int MAX_LIGHTS = 8;

//Structure that will hold the PBR data
struct Material
{
	vec4 color;
	float roughness;
	float metallic;
	float ao;
};

//Light properties
struct Light
{
	vec3 position;
	vec3 color;
};

//Final color to set
out vec4 FragColor;

//Position of the pixel
in vec3 pos_world;

//Corresponding normal of the pixel
in vec3 transformed_normal;

//Variables for the PBR computation
uniform Material material_to_use;
uniform int number_of_lights;
uniform Light lights[MAX_LIGHTS];
uniform vec3 camera_position;

//Environment maps
uniform samplerCube irradiance_map;
uniform samplerCube prefilter_map;
uniform sampler2D lut_texture;

float DistributionGGX(vec3 N, vec3 H, float roughness)
{
	//Normal distribution function numerator part
    float a = roughness*roughness;
    float a2 = a*a;
    
	//Denominatior part
	float NdotH = max(dot(N, H), 0.0);
    float NdotH2 = NdotH*NdotH;

    float nom   = a2;
    float denom = (NdotH2 * (a2 - 1.0) + 1.0);
    denom = PI * denom * denom;

    return nom / denom;
}


//Self shadowing microfacets functions
float GeometrySchlickGGX(float NdotV, float roughness)
{
	//Direct ligthing
    float r = (roughness + 1.0);
	float k = (r*r) / 8.0;
	
	//Combination of GGX and Schlick Beckmann approximation
    float nom   = NdotV;
    float denom = NdotV * (1.0 - k) + k;

    return nom / denom;
}

float GeometrySmith(vec3 N, vec3 V, vec3 L, float roughness)
{
	//Angle between the normal and the view vector
    float NdotV = max(dot(N, V), 0.0);
    
	//Angle between the normal and the light vector
	float NdotL = max(dot(N, L), 0.0);
    
	//GGX geometry computation using the view vector
	float ggx2 = GeometrySchlickGGX(NdotV, roughness);
	
	//GGX geometry computation using the light vector
    float ggx1 = GeometrySchlickGGX(NdotL, roughness);

    return ggx1 * ggx2;
}


//Ratio of surface reflection functions
vec3 fresnelSchlick(float cosTheta, vec3 F0)
{
	//Compute the fresnel-Schlick approximation
    return F0 + (1.0 - F0) * pow(clamp(1.0 - cosTheta, 0.0, 1.0), 5.0);
}


vec3 fresnelSchlickRoughness(float cosTheta, vec3 F0, float roughness)
{
	//Compute the fresnel-Schlick approximation taking into account the roughness
    return F0 + (max(vec3(1.0 - roughness), F0) - F0) * pow(clamp(1.0 - cosTheta, 0.0, 1.0), 5.0);
}

void main()
{
	//Normalize the given in the normal just in case
	vec3 normalized_normal = normalize(transformed_normal);
	
	//From pixel to camera
	vec3 view_vector = normalize(camera_position - pos_world);
	
	//Reflected vector on the pixel
	vec3 reflection = reflect(-view_vector,normalized_normal);
	
	//This value is hardcoded as 0.04 because we are setting a surface response at normal incidence
	//or the base reflectivity (this one is of the plastic), we could be able to set this in the program 
	//instead of hardcoding  it, but for this project having it like this is ok 
	vec3 F0 = vec3(0.04f); 
	
	//We compute F0 for both dielectercis and conductors, we do it in this way if the surface is metallic
    F0 = mix(F0, vec3(material_to_use.color), material_to_use.metallic);
	
	//Variable for the final light reflectance
	vec3 Lo = vec3(0.0);
	
	//Go through all lights
	for(int i = 0; i < number_of_lights; i++) 
    {
		//Vector from pixel to light
		vec3 L = normalize(lights[i].position - pos_world);
        
		//Direction of the vector from the camera and the light to the pixel
		vec3 H = normalize(view_vector + L);
		
		//How much distance is from the light to the pixel
		float distance = length(lights[i].position - pos_world);
        
		//Compute light attenuation based on the computed distance
		float attenuation = 1.0 / (distance * distance);
        
		//Compute the radiance color of the current light
		vec3 radiance = lights[i].color * attenuation;
		
		//Cook Torrance part (BRDF) (specular part), how does the light interact with the microfacets of the surface,
		//taking into account the roughness of the material
		
		//Approximate the amount of surface microfacets that are alligned to the halfway vector (H), taking into acount the roughness
		float NDF = DistributionGGX(normalized_normal, H, material_to_use.roughness);   
        
		//Self shadowing properties of the microfacets
		float G = GeometrySmith(normalized_normal, view_vector, L, material_to_use.roughness);
		
		//Ratio of surface reflection at different surface angles
        vec3 F = fresnelSchlick(max(dot(H, view_vector), 0.0), F0);
		
		//Compute the respective specular component with the Cook-Torrance equation
		vec3 numerator    = NDF * G * F; 
        float denominator = 4 * max(dot(normalized_normal, view_vector), 0.0) * max(dot(normalized_normal, L), 0.0) + 0.0001; // + 0.0001 to prevent divide by zero
        vec3 specular = numerator / denominator;
		
		//Respective reflection/specular fraction is equal to the Fresnel-Schlick given ratio
		vec3 kS = F;
		
        //For energy conservation, the diffuse and specular light can't
        //be above 1.0 (unless the surface emits light). For that the diffuse
		//is the substraction between 1 and the specular component
        vec3 kD = vec3(1.0) - kS;
		
		
		//We multiply the respective diffuse component by (1 - metalness) as 
		//complete metals do not have diffuse lighting, and if they are half metal
		//they will have a linear blend
        kD *= 1.0 - material_to_use.metallic;	  

        //Check if the dot product between the light to pixel vector and the pixel normal is bigger than 0
        float NdotL = max(dot(normalized_normal, L), 0.0);        

        //Add to the final outgoing light reflectance using the final reflectance equation
        Lo += (kD * vec3(material_to_use.color) / PI + specular) * radiance * NdotL;
	}
		
	//Compute the Fresnel-Schlick ratio for the environment part
	vec3 F = fresnelSchlickRoughness(max(dot(normalized_normal, view_vector), 0.0), F0, material_to_use.roughness);
	
	//Same as with the lights, the energy has to be mantained for the environment
	vec3 kS = F;
	vec3 kD = 1.0 - kS;
	
	//Again, multiply the diffuse factor by (1 - metalness) as 
	//complete metals do not have diffuse lighting, and if they are half metal
	//they will have a linear blend
    kD *= 1.0 - material_to_use.metallic;
	
	//Get the irradiance light generated by the environment
    vec3 irradiance = texture(irradiance_map, normalized_normal).rgb;
	
	//Compute the final diffuse factor of the environment part
    vec3 diffuse = irradiance * vec3(material_to_use.color);
		
	//This is hardcoded for the level of detail of the environment reflection, this is in this way for a reason
	//in computer graphics (mipmaps), not related with physics, dont care about this
	const float MAX_REFLECTION_LOD = 4.0;
	
	//This part is to get the imaged based lighting specular part, for this we get the respective reflected pixel of 
	//a prefiltered map of the environment and a special integrated precomputed texture called the lut or BRDF 
	//(bidirectional reflective distribution function, Cook-Torrance part again) texture. Then we will combine both samples for the 
	//Split-Sum approximation part
	vec3 prefilteredColor = textureLod(prefilter_map, reflection, material_to_use.roughness * MAX_REFLECTION_LOD).rgb;    
	vec2 brdf  = texture(lut_texture, vec2(max(dot(normalized_normal,view_vector), 0.0), material_to_use.roughness)).rg;
	
	//Final specular part taking into account the environment
	vec3 specular = prefilteredColor * (F * brdf.x + brdf.y);	
	
	//Compute the final ambient light using the previously computed specular and diffuse of the environment
	vec3 ambient = (kD * diffuse + specular) * material_to_use.ao;

	//Compute the color (before the color correction itself) adding the computed light reflection of the lights to the ambient color
    vec3 color = ambient + Lo;

    // HDR tonemapping
    color = color / (color + vec3(1.0));
	
    // gamma correction for not having burned colors
    color = pow(color, vec3(1.0/2.2)); 

	//Set the final color
    FragColor = vec4(color, 1.f);

}