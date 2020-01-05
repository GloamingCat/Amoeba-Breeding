
// =================================================================================================
// Amoeba Type
// =================================================================================================

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
	genes as float[444]
	for i = 1 to 444
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

function AmoebaColors(a as Amoeba)
	colors as float[]
	// TODO
endfunction colors

function AmoebaOffsets(a as Amoeba)
	offsets as float[]
	// TODO
endfunction offsets

// =================================================================================================
// Primary Fenotypes - Food
// =================================================================================================

function AmoebaDigestion(a as Amoeba)
	x as float = 0
	// TODO
endfunction x

function AmoebaSpeed(a as Amoeba)
	x as float = 0
	// TODO
endfunction x

function AmoebaAbsorption(a as Amoeba)
	x as float = 0
	// TODO
endfunction x

// =================================================================================================
// Primary Fenotypes - Attraction
// =================================================================================================

function AmoebaFormatAttraction(a as Amoeba)
	x as float = 0
	// TODO
endfunction x

function AmoebaSizeAttraction(a as Amoeba)
	x as float = 0
	// TODO
endfunction x

function AmoebaRGBAttraction(a as Amoeba)
	x as float[3]
	// TODO
endfunction x

function AmoebaColorVariationAttraction(a as Amoeba)
	x as float = 0
	// TODO
endfunction x

// =================================================================================================
// Secondary Fenotypes
// =================================================================================================

function AmoebaFormat(a as Amoeba)
	x as float = 0
	// TODO
endfunction x

function AmoebaSize(a as Amoeba)
	x as float = 0
	// TODO
endfunction x

function AmoebaRGB(a as Amoeba)
	x as float[3]
	// TODO
endfunction x

function AmoebaColorVariation(a as Amoeba)
	x as float = 0
	// TODO
endfunction x

// =================================================================================================
// Procreation
// =================================================================================================

function AmoebaAttracts(a as Amoeba, b as Amoeba, rate as float)
	attraction as float = 0
	attraction = attraction + AmoebaFormat(a) * AmoebaFormatAttraction(b)
	attraction = attraction + AmoebaSize(a) * AmoebaSizeAttraction(b)
	attraction = attraction + AmoebaColorVariation(a) * AmoebaColorVariationAttraction(b)
	rgb as float[]
	rgb = AmoebaRGB(a)
	rgbAttraction as float[]
	rgbAttraction = AmoebaRGBAttraction(b)
	for i = 1 to 3 
		attraction = attraction + rgb[i] * rgbAttraction[i]
	next i
	result = RandomFloat() * 6 < rate * attraction
endfunction result

function OnePointCrossover(a as Amoeba, b as Amoeba, c as Amoeba)
	point = Random(1, 443)
	for i = 1 to point
		c.genes.insert(a.genes[i])
	next i
	for i = point + 1 to b.genes.length
		c.genes.insert(b.genes[i])
	next i
endfunction

function AlternatingCrossover(a as Amoeba, b as Amoeba, c as Amoeba)
	point = Random(1, 443)
	for i = 1 to a.genes.length
		if Random(1, 2) = 1
			c.genes.insert(a.genes[i])
		else
			c.genes.insert(b.genes[i])
		endif
	next i
endfunction
