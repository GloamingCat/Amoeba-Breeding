
// =================================================================================================
// Lab Data
// =================================================================================================

global flasks as Flask[]
global remainingFood as integer
global remainingCoins as integer
global storedAmoeba as Amoeba

function InitData()
	flasks.length = 4
	for i = 1 to 4
		InitPopulation(flasks[i])
	next i
	remainingFood = 500
	remainingCoins = 100
	EraseAmoeba(storedAmoeba)
endfunction

// =================================================================================================
// Logging
// =================================================================================================

function DumpAmoeba(a ref as Amoeba)
	Log("Position: " + Str(a.x) + ", " + Str(a.y))
	Log("Life: " + Str(a.life))
	genes$ = ""
	for i = 1 to a.genes.length
		genes$ = genes$ + Str(a.genes[i]) + " "
	next i
	Log("Genes: " + genes$)
endfunction

function DumpFlask(fl ref as Flask)
	Log("Procreation Rate: " + Str(fl.procreationRate))
	Log("Mutation Rate: " + Str(fl.mutationRate))
	Log("Attraction Radius: " + Str(fl.attractionRadius))
	for i = 1 to fl.population.length
		Log(i)
		DumpAmoeba(fl.population[i])
	next i
endfunction

// =================================================================================================
// Load
// =================================================================================================

function LoadAmoeba(a ref as Amoeba, fileID as integer)
	a.life = ReadFloat(fileID)
	a.x = ReadFloat(fileID)
	a.y = ReadFloat(fileID)
	a.genes.length = NGENES
	for i = 1 to NGENES
		a.genes[i] = ReadFloat(fileID)
	next i
endfunction

function LoadLab(fileID as integer)
	remainingFood = ReadInteger(fileID)
	remainingCoins = ReadInteger(fileID)
	hasStoredAmoeba = ReadInteger(fileID)
	if hasStoredAmoeba
		LoadAmoeba(storedAmoeba, fileID)
	else
		EraseAmoeba(storedAmoeba)
	endif
	flasks.length = ReadInteger(fileID)
	for f = 1 to flasks.length
		flasks[f].procreationRate = ReadFloat(fileID)
		flasks[f].mutationRate = ReadFloat(fileID)
		flasks[f].attractionRadius = ReadFloat(fileID)
		flasks[f].population.length = ReadInteger(fileID)
		for a = 1 to flasks[f].population.length
			LoadAmoeba(flasks[f].population[a], fileID)
		next a
	next f
endfunction

function LoadGame()
	if GetFileExists("save")
		fileID = OpenToRead("save")
		LoadLab(fileID)
		CloseFile(fileID)
	else
		InitData()
	endif
endfunction

// =================================================================================================
// Save
// =================================================================================================

function SaveAmoeba(a ref as Amoeba, fileID as integer)
	WriteFloat(fileID, a.life)
	WriteFloat(fileID, a.x)
	WriteFloat(fileID, a.y)
	for i = 1 to NGENES
		WriteFloat(fileID, a.genes[i])
	next i
endfunction

function SaveLab(fileID as integer)
	WriteInteger(fileID, remainingFood)
	WriteInteger(fileID, remainingCoins)
	if storedAmoeba.genes.length
		SaveAmoeba(storedAmoeba, fileID)
		WriteInteger(fileID, 1)
	else
		WriteInteger(fileID, 0)
	endif
	WriteInteger(fileID, flasks.length)
	for f = 1 to flasks.length
		WriteFloat(fileID, flasks[f].procreationRate)
		WriteFloat(fileID, flasks[f].mutationRate)
		WriteFloat(fileID, flasks[f].attractionRadius)
		WriteFloat(fileID, flasks[f].population.length)
		for a = 1 to flasks[f].population.length
			SaveAmoeba(flasks[f].population[a], fileID)
		next a
	next f
endfunction

function SaveGame()
	fileID = OpenToWrite("save")
	SaveLab(fileID)
	CloseFile(fileID)
endfunction
