
// =================================================================================================
// Flask Type
// =================================================================================================

type Flask 
	population as Amoeba[]
	procreationRate as float
	mutationRate as float
	attractionRadius as float
endtype

function InitPopulation(fl ref as Flask)
	fl.population.length = 15
	for i = 1 to 15
		RandomizeGenes(fl.population[i])
		RandomizePosition(fl.population[i])
		fl.population[i].life = 100
	next i
	fl.procreationRate = 0.5
	fl.mutationRate = 0.05
	fl.attractionRadius = 0.5
endfunction

function ShuffleFlask(fl ref as Flask)
	for i = 1 to fl.population.length
		RandomizePosition(fl.population[i])
	next i
endfunction

function SimulationStep(fl ref as Flask)
	newPopulation as Amoeba[]
	for i = 1 to fl.population.length
		fl.population[i].life = fl.population[i].life - AmoebaDigestion(fl.population[i])
		if fl.population[i].life > 0 then newPopulation.insert(fl.population[i])
	next i
	size = newPopulation.length
	for i = 1 to size
		for j = i + 1 to size
			if CanProcreate(newPopulation[i], newPopulation[j], fl.attractionRadius, fl.procreationRate)
				newPopulation.insert(Procreate(newPopulation[i], newPopulation[j], fl.mutationRate))
			endif
		next j
	next i
	fl.population = newPopulation
endfunction

// =================================================================================================
// Procreation
// =================================================================================================

function CanProcreate(a as Amoeba, b as Amoeba, radius as float, rate as float)
	result as integer
	dx = (a.x - b.x)
	dy = (a.y - b.y)
	if dx * dx + dy * dy > radius * radius
		result = 0
	else
		result = AmoebaAttracts(a, b, rate) and AmoebaAttracts(b, a, rate)
	endif
endfunction result

function Procreate(a as Amoeba, b as Amoeba, rate as float)
	child as Amoeba
	OnePointCrossOver(a, b, child)
	//AlternatingCrossOver(a, b, child)
endfunction child

// =================================================================================================
// Interaction
// =================================================================================================

function FeedFlask(fl ref as Flask, totalFood as integer)
	totalSpeed as float = 0
	for i = 1 to fl.population.length
		totalSpeed = totalSpeed + AmoebaSpeed(fl.population[i])
	next i
	for i = 1 to fl.population.length
		food as float 
		food = totalFood * AmoebaAbsorption(fl.population[i]) * AmoebaSpeed(fl.population[i]) / totalSpeed
		fl.population[i].life = fl.population[i].life + food
	next i
endfunction

function DropAmoeba(fl ref as Flask)
	RandomizePosition(storedAmoeba)
	fl.population.insert(storedAmoeba)
	EraseAmoeba(storedAmoeba)
endfunction
