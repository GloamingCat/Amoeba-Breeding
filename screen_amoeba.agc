
// =================================================================================================
// Amoeba Screen
// =================================================================================================

#constant AMOEBAZOOMSIZE 300

// Amoeba ID.
global selectedAmoeba as integer = -1
function SetSelectedAmoeba(id as integer)
	selectedAmoeba = id
endfunction

global amoebaSprite as integer
amoebaSprite = CreateSprite(0)
SetSpritePosition(amoebaSprite, GetVirtualWidth() / 2 - 50, GetVirtualHeight() - 150)
SetSpriteColor(amoebaSprite, 255, 255, 255, 255)
SetSpriteSize(amoebaSprite, AMOEBAZOOMSIZE, AMOEBAZOOMSIZE)
SetSpriteVisible(amoebaSprite, 0)

// Discard amoeba
global killButton as integer
killButton = CreateSprite(0)
SetSpritePosition(killButton, -300 + GetVirtualWidth() / 2 - 50, GetVirtualHeight() - 150)
SetSpriteColor(killButton, 255, 0, 0, 255)
SetSpriteSize(killButton, 100, 100)
SetSpriteVisible(killButton, 0)

// Pick amoeba
global storeButton as integer
storeButton = CreateSprite(0)
SetSpritePosition(storeButton, GetVirtualWidth() / 2 - 50, GetVirtualHeight() - 150)
SetSpriteColor(storeButton, 0, 255, 255, 255)
SetSpriteSize(storeButton, 100, 100)
SetSpriteVisible(storeButton, 0)

// Return button
global returnAmoebaButton as integer
returnAmoebaButton = CreateSprite(0)
SetSpritePosition(returnAmoebaButton, 300 + GetVirtualWidth() / 2 - 50, GetVirtualHeight() - 150)
SetSpriteColor(returnAmoebaButton, 255, 255, 255, 255)
SetSpriteSize(returnAmoebaButton, 100, 100)
SetSpriteVisible(returnAmoebaButton, 0)

// State
// 0 => Nothing open.
// 1 => Confirm window open.
global amoebaState as integer = 0

// =================================================================================================
// Visibility
// =================================================================================================

// Show / hide buttons.
function SetAmoebaScreenVisible(visible as integer)
	SetSpriteVisible(amoebaSprite, visible)
	SetSpriteVisible(killButton, visible)
	SetSpriteVisible(storeButton, visible)
	SetSpriteVisible(returnAmoebaButton, visible)
	if visible then state = 4
endfunction

function RemoveAndReturn()
	flasks[selectedFlask].population.remove(selectedAmoeba)
	selectedAmoeba = -1
	SetAmoebaScreenVisible(0)
	SetFlaskScreenVisible(1)
endfunction

// =================================================================================================
// Check Input
// =================================================================================================

// Check state.
function AmoebaScreen()
	Print("Amoeba")
	if amoebaState = 0
		//Nothing open.
		CheckAmoebaButtons()
	elseif amoebaState = 1
		// Confirm button open.
	endif
endfunction

// Check button input.
function CheckAmoebaButtons()
	if GetPointerPressed() = 1
		if GetSpriteHitTest(killButton, GetPointerX(), GetPointerY()) = 1
			RemoveAndReturn()
		elseif GetSpriteHitTest(storeButton, GetPointerX(), GetPointerY()) = 1
			storedAmoeba = flasks[selectedFlask].population[selectedAmoeba]
			RemoveAndReturn()
		elseif GetSpriteHitTest(returnAmoebaButton, GetPointerX(), GetPointerY()) = 1
			SetAmoebaScreenVisible(0)
			SetFlaskScreenVisible(1)
		endif
	endif
endfunction
