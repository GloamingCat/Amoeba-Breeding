
// =================================================================================================
// Amoeba Graphics
// =================================================================================================

#constant MAXOFFSET 0.25

global amoebaObject as integer
global amoebaShader as integer
global amoebaMesh as integer
global amoebaVertexPositions as float[]

// HSL to RGB convertion.
function HSV2RGB(h as float, s as float, v as float)
    rgb as integer[3]
endfunction rgb


function LoadAmoebaMesh()
	amoebaObject = LoadObject("Amoeba.obj")
	amoebaShader = LoadShader("vertex.glsl", "pixel.glsl")
	amoebaMesh = CreateMemblockFromObjectMesh(amoebaObject, 1)
	SetObjectShader(amoebaObject, amoebaShader)
	SetObjectScale(amoebaObject, 10, 10, 1)
	SetObjectVisible(amoebaObject, 0)
	amoebaVertexPositions.length = NVERTICES*2
	for i = 0 to NVERTICES-1
		amoebaVertexPositions[i*2+1] = GetMeshMemblockVertexX(amoebaMesh, i)
		amoebaVertexPositions[i*2+2] = GetMeshMemblockVertexY(amoebaMesh, i)
	next i
endfunction

function SetMeshAttributes(genes ref as float[])
	for i = 0 to NVERTICES-1
		x as float
		x = amoebaVertexPositions[i*2+1] + genes[i*3+1] * MAXOFFSET
		y as float
		y = amoebaVertexPositions[i*2+2] + genes[i*3+2] * MAXOFFSET
		SetMeshMemblockVertexPosition(amoebaMesh, i, x, y, 0)
		SetMeshMemblockVertexUV(amoebaMesh, i, genes[i+NVERTICES+1], genes[i+NVERTICES*2+1])
	next i
	SetObjectMeshFromMemblock(amoebaObject, 1, amoebaMesh)
endfunction

LoadAmoebaMesh()
