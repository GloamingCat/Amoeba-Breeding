
// Lab data
global flasks as Flask[4]
for i = 1 to 4
	InitPopulation(flasks[i])
next i
global remainingFood = 500
global remainingCoins = 100
global storedAmoeba as Amoeba

function LoadGame()
	fileID = OpenToRead("save")
	
	// TODO
endfunction

function SaveGame()
	fileID = OpenToWrite("save")
	
	// TODO
endfunction
