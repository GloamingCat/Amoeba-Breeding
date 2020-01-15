
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
    if s = 0
		vv = Round(v*255)
		rgb[1] = vv
		rgb[2] = vv
		rgb[3] = vv
	else
		if h < 0 then h = h + 1
		if h >= 1 then h = h - 1
		hh# = h * 6
		i = Round(hh#)
		Log(Str(i) + " " + Str(h))
		ff# = hh# - i
		p = Round(v * (1.0 - s) * 255)
		q = Round(v * (1.0 - (s * ff#)) * 255)
		t = Round(v * (1.0 - (s * (1.0 - ff#))) * 255)
 		if i = 0 
			rgb[1] = v
			rgb[2] = t
			rgb[3] = p
		elseif i = 1
            rgb[1] = q
            rgb[2] = v
            rgb[3] = p
		elseif i = 2
            rgb[1] = p
            rgb[2] = v
            rgb[3] = t
		elseif i = 3
            rgb[1] = p
            rgb[2] = q
            rgb[3] = v
		elseif i = 4
            rgb[1] = t
            rgb[2] = p
            rgb[3] = v
		else //if = 5
            rgb[1] = v
            rgb[2] = p
            rgb[3] = q
		endif
	endif
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
