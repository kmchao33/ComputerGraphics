#version 150

in vec4 aPosition;
in vec3 aNormal;

uniform mat4 uProjectionMatrix;
uniform mat4 uModelViewMatrix;

uniform vec3 uLightPosition;
uniform vec3 uLightColor;
uniform float uLightSpotLightFactor;

uniform mat3 uAmbientMaterial;
uniform mat3 uDiffuseMaterial;
uniform mat3 uSpecularMaterial;
uniform float uSpecularityExponent;

out vec3 vColor;

void main() {
    vec4 newPosition = uModelViewMatrix * aPosition;
    gl_Position = uProjectionMatrix * newPosition;
    
    mat3 m_MVM = mat3(uModelViewMatrix);
    
    vec3 n = normalize(inverse(transpose(m_MVM)) * aNormal);
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
    
    vec3 o = vec3(uModelViewMatrix * vec4(0.0, 0.0, 0.0, 1.0));
    vec3 d = normalize(o - uLightPosition);
    float scalar_spotlight = pow(dot(d, -w_lp), uLightSpotLightFactor);
    
    c_Total = c_Ambient + scalar_spotlight * (c_Diffuse + c_Specular);
    vColor = c_Total;
}
