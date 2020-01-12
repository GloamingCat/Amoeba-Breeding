
// Per-object informaition
uniform mat4 agk_WorldViewProj; // View projection matrix
uniform vec4 agk_MeshDiffuse; // Object color

// Per-vertex information 
attribute vec4 position;
attribute vec3 normal;
attribute vec2 uv;
  
// Per-pixel information (output)
varying vec4 vertex_color;
  
vec3 hsl2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
  
void main()
{
   gl_Position = agk_WorldViewProj * position;
   vertex_color = agk_MeshDiffuse;
   vec3 c = hsl2rgb(vec3(uv.x, abs(uv.y), 1));
   vertex_color *= vec4(c.x, c.y, c.z, 1);
}