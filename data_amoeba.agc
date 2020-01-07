
// =================================================================================================
// Amoeba Type
// =================================================================================================

#constant NGENES 268
#constant NVERTICES 65
#constant CENTERV 16

type Amoeba
	genes as float[]
	life as float
	x as float
	y as float
endtype

function RandomFloat()
	r as float
	r = Random(0, 10000)
	r = r / 10000
endfunction r

function RandomGene()
	gene as float
	gene = RandomFloat() * 2 - 1
endfunction gene

function EraseAmoeba(a ref as Amoeba)
	genes as float[]
	a.genes = genes
endfunction

function RandomizeGenes(a ref as Amoeba)
	genes as float[NGENES]
	for i = 1 to NGENES
		genes[i] = RandomGene()
	next i
	a.genes = genes
endfunction
	
function RandomizePosition(a ref as Amoeba)
	radius as float
	radius = RandomFloat()
	angle as float
	angle = RandomFloat() * 360
	a.x = radius * Cos(angle)
	a.y = radius * Sin(angle)
endfunction

// =================================================================================================
// Primary Fenotypes - Appearance
// =================================================================================================

function AmoebaHues(a ref as Amoeba)
	colors as float[NVERTICES]
	for i = 1 to NVERTICES
		colors[i] = a.genes[i]
	next i
endfunction colors

function AmoebaLightness(a ref as Amoeba)
	start = NVERTICES
	light as float[NVERTICES]
	for i = 1 to NVERTICES
		light[i] = a.genes[i + start]
	next i
endfunction light

function AmoebaOffsetsX(a ref as Amoeba)
	start = NVERTICES * 2
	offsets as float[NVERTICES]
	for i = 1 to NVERTICES
		offsets[i] = a.genes[i + start]
	next i
	offsets[CENTERV] = 0
endfunction offsets

function AmoebaOffsetsY(a ref as Amoeba)
	start = NVERTICES * 3
	offsets as float[NVERTICES]
	for i = 1 to NVERTICES
		offsets[i] = a.genes[i + start]
	next i
	offsets[CENTERV] = 0
endfunction offsets


// =================================================================================================
// Primary Fenotypes - Food
// =================================================================================================

function AmoebaDigestion(a ref as Amoeba)
	start = NVERTICES * 4
	x as float
	x = a.genes[start + 1]
endfunction x

function AmoebaSpeed(a ref as Amoeba)
	start = NVERTICES * 4 + 1
	x as float
	x = a.genes[start + 1]
endfunction x

function AmoebaAbsorption(a ref as Amoeba)
	start = NVERTICES * 4 + 2
	x as float
	x = a.genes[start + 1]
endfunction x

// =================================================================================================
// Primary Fenotypes - Attraction
// =================================================================================================

function AmoebaFormatAttraction(a ref as Amoeba)
	start = NVERTICES * 4 + 3
	x as float
	x = a.genes[start + 1]
endfunction x

function AmoebaSizeAttraction(a ref as Amoeba)
	start = NVERTICES * 4 + 4
	x as float
	x = a.genes[start + 1]
endfunction x

function AmoebaLightAttraction(a ref as Amoeba)
	start = NVERTICES * 4 + 5
	x as float
	x = a.genes[start + 1]
endfunction x

function AmoebaHueAttraction(a ref as Amoeba)
	start = NVERTICES * 4 + 6
	x as float
	x = a.genes[start + 1]
endfunction x

function AmoebaHueVariationAttraction(a ref as Amoeba)
	start = NVERTICES * 4 + 7
	x as float
	x = a.genes[start + 1]
endfunction x

// =================================================================================================
// Secondary Fenotypes
// =================================================================================================

// Format (perimeter) variation.
function AmoebaFormat(a ref as Amoeba)
	x as float = 0
	// TODO
endfunction x

// Total area.
function AmoebaSize(a ref as Amoeba)
	x as float = 0
	// TODO
endfunction x

// Average lightness.
function AmoebaLightMean(a ref as Amoeba)
	x as float = 0
	light as float[]
	light = AmoebaLightness(a)
	for i = 1 to light.length
		x = x + light[i]
	next i
	x = x / light.length
endfunction x

// Average hue.
function AmoebaHueMean(a ref as Amoeba)
	x as float = 0
	hues as float[]
	hues = AmoebaHues(a)
	for i = 1 to hues.length
		x = x + hues[i]
	next i
	x = x / hues.length
endfunction x

// Hue variation among vertices.
function AmoebaHueVariation(a as Amoeba)
	x as float = 0
	mean as float
	mean = AmoebaHueMean(a)
	hues as float[]
	hues = AmoebaHues(a)
	for i = 1 to hues.length
		x = x + (hues[i] - mean) * (hues[i] - mean)
	next i
	x = x / hues.length
endfunction x

// Hue distance from a preferred hue (if 0, distance to red).
function AmoebaHueDistance(a ref as Amoeba, faveHue as float)
	hue as float
	hue = AmoebaHueMean(a)
	// Offset color
	hue = hue - faveHue
	if hue > 1
		hue = hue - 1
	elseif hue < 0
		hue = hue + 1
	endif
	// Closeness to red (from 0.5 to 1)
	if hue < 0.5
		hue = 1 - hue
	endif
	// Adjust to (-1, 1)
	hue = (hue - 0.75) * 4
endfunction hue

// =================================================================================================
// Procreation
// =================================================================================================

// Attraction rate from amoeba B towards amoeba A.
function AmoebaAttracts(a ref as Amoeba, b ref as Amoeba, rate as float)
	attraction as float = 0
	attraction = attraction + AmoebaFormat(a) * AmoebaFormatAttraction(b)
	attraction = attraction + AmoebaSize(a) * AmoebaSizeAttraction(b)
	attraction = attraction + AmoebaLightMean(a) * AmoebaLightAttraction(b)
	attraction = attraction + AmoebaHueVariation(a) * AmoebaHueVariationAttraction(b)
	attraction = attraction + AmoebaHueDistance(a, AmoebaHueAttraction(b))
	result = result / 5
endfunction result

// Picks a random point and swaps A's and B's cromossomes at this point.
function OnePointCrossover(a as Amoeba, b as Amoeba, c as Amoeba)
	point = Random(1, NGENES - 1)
	c.genes.length = NGENES
	for i = 1 to point
		c.genes[i] = a.genes[i]
	next i
	for i = point + 1 to NGENES
		c.genes[i] = b.genes[i]
	next i
endfunction

// Creates a entirely new cromossome randomly picking genes from either A's or B's.
function AlternatingCrossover(a as Amoeba, b as Amoeba, c as Amoeba)
	point = Random(1, NGENES - 1)
	c.genes.length = NGENES
	for i = 1 to NGENES
		if Random(1, 2) = 1
			c.genes[i] = a.genes[i]
		else
			c.genes[i] = b.genes[i]
		endif
	next i
endfunction
