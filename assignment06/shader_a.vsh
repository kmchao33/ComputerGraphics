#version 150

in vec4 aPosition;
in vec3 aNormal;

uniform mat4 uProjectionMatrix;
uniform mat4 uModelViewMatrix;

uniform vec3 uLightPosition;
uniform vec3 uLightColor;

uniform mat3 uAmbientMaterial;
uniform mat3 uDiffuseMaterial;
uniform mat3 uSpecularMaterial;
uniform float uSpecularityExponent;

out vec3 vColor;

void main() {
    vec4 newPosition = uModelViewMatrix * aPosition;
    gl_Position = uProjectionMatrix * newPosition;
    
    vec3 n = normalize(inverse(transpose(mat3(uModelViewMatrix))) * aNormal);
    vec3 p = vec3(newPosition);
    vec3 v = vec3(0.0, 0.0, 0.0);
    
    vec3 w_lp, w_vp;
    w_lp = normalize(uLightPosition - p);
    w_vp = normalize(v - p);
    
    vec3 c_Total, c_Ambient, c_Diffuse, c_Specular;
    c_Ambient = uAmbientMaterial * uLightColor;
    
    float cosPhi = dot(n, w_lp);
    c_Diffuse = uDiffuseMaterial * uLightColor * cosPhi;
    
    vec3 h = normalize(w_lp + w_vp);
    c_Specular = uSpecularMaterial * uLightColor * pow(dot(n, h), uSpecularityExponent);
    
    c_Total = c_Ambient + c_Diffuse + c_Specular;
    vColor = c_Total;
}
