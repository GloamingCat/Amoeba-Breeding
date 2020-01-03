// combined model/view/projection matrix
uniform mat4 agk_WorldViewProj;
  
// Per-vertex position information 
attribute vec4 position;
  
// vertex color
uniform vec4 agk_MeshDiffuse;
  
// Only used to send dat to the pixel/fragment shader
varying vec4 vertex_color;
  
void main()
{
   vertex_color = agk_MeshDiffuse;
   gl_Position = agk_WorldViewProj * position;
}