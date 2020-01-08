
// =================================================================================================
// Flask Screen
// =================================================================================================

#constant FLASKSIZE 600
#constant AMOEBASIZE 8

// Flask ID.
global selectedFlask as integer = -1
function SetSelectedFlask(id as integer)
	selectedFlask = id
endfunction
global flaskSprite as integer
flaskSprite = CreateSprite(0)
SetSpritePosition(flaskSprite, (GetVirtualWidth() - FLASKSIZE) / 2, (GetVirtualHeight() - FLASKSIZE) / 2)
SetSpriteColor(flaskSprite, 0, 255, 255, 255)
SetSpriteSize(flaskSprite, FLASKSIZE, FLASKSIZE)
SetSpriteVisible(flaskSprite, 0)

// Shuffle button
global shuffleButton as integer
shuffleButton = CreateSprite(0)
SetSpritePosition(shuffleButton, -300 + GetVirtualWidth() / 2 - 50, GetVirtualHeight() - 150)
SetSpriteColor(shuffleButton, 255, 0, 255, 255)
SetSpriteSize(shuffleButton, 100, 100)
SetSpriteVisible(shuffleButton, 0)

// Radiation button
global radiationButton as integer
radiationButton = CreateSprite(0)
SetSpritePosition(radiationButton, GetVirtualWidth() / 2 - 50, GetVirtualHeight() - 150)
SetSpriteColor(radiationButton, 255, 255, 0, 255)
SetSpriteSize(radiationButton, 100, 100)
SetSpriteVisible(radiationButton, 0)

// Return button
global returnFlaskButton as integer
returnFlaskButton = CreateSprite(0)
SetSpritePosition(returnFlaskButton, 300 + GetVirtualWidth() / 2 - 50, GetVirtualHeight() - 150)
SetSpriteColor(returnFlaskButton, 255, 255, 255, 255)
SetSpriteSize(returnFlaskButton, 100, 100)
SetSpriteVisible(returnFlaskButton, 0)

// Amoeba buttons
global amoebaButtons as integer[]

// State
// 0 => Nothing open.
// 1 => Radiation spinner open.
flaskState as integer = 0

// =================================================================================================
// Visibility
// =================================================================================================

// Show / hide buttons.
function SetFlaskScreenVisible(visible as integer)
	RefreshFlaskAmoebaButtons(visible)
	SetSpriteVisible(flaskSprite, visible)
	SetSpriteVisible(radiationButton, visible)
	SetSpriteVisible(shuffleButton, visible)
	SetSpriteVisible(returnFlaskButton, visible)
	for i = 1 to amoebaButtons.length
		SetSpriteVisible(amoebaButtons[i], visible)
	next i
	if visible then state = 3
endfunction

// Refresh all buttons.
function RefreshFlaskAmoebaButtons(visible as integer)
	// Missing
	for i = amoebaButtons.length + 1 to flasks[selectedFlask].population.length
		amoebaButtons.insert(CreateSprite(0))
	next i
	// Exceeding
	for i = flasks[selectedFlask].population.length + 1 to amoebaButtons.length
		DeleteSprite(amoebaButtons[i])
	next i
	amoebaButtons.length = flasks[selectedFlask].population.length
	for i = 1 to amoebaButtons.length
		x as float
		x = flasks[selectedFlask].population[i].x
		x = (GetVirtualWidth() - FLASKSIZE * x) / 2 - AMOEBASIZE / 2
		y as float
		y = flasks[selectedFlask].population[i].y
		y = (GetVirtualHeight() - FLASKSIZE * y) / 2 - AMOEBASIZE / 2
		hue as float
		hue = AmoebaHueMean(flasks[selectedFlask].population[i])
		light as float
		light = AmoebaLightMean(flasks[selectedFlask].population[i])
		color as integer[]
		color = HL2RGB(hue, light)
		alpha = AmoebaTransparency(flasks[selectedFlask].population[i])
		SetSpritePosition(amoebaButtons[i], Round(x), Round(y))
		SetSpriteColor(amoebaButtons[i], color[1], color[2], color[3], alpha)
		SetSpriteSize(amoebaButtons[i], AMOEBASIZE, AMOEBASIZE)
		SetSpriteVisible(amoebaButtons[i], visible)
	next i
endfunction

// =================================================================================================
// Check Input
// =================================================================================================

// Check state.
function FlaskScreen()
	Print("Flask")
	if flaskState = 0
		//Nothing open.
		CheckFlaskButtons()
	elseif flaskState = 1
		// Radiation spinner open.
		if spinnerValue = -1
			if UpdateSpinner() = 0
				CloseSpinner()
				flaskState = 0
			endif
		else
			flasks[selectedFlask].mutationRate = spinnerValue * 0.01
			CloseSpinner()
			labState = 0
		endif
	endif
endfunction

// Check button input.
function CheckFlaskButtons()
	if GetPointerPressed() = 1
		if GetSpriteHitTest(radiationButton, GetPointerX(), GetPointerY()) = 1
			// Open spinner.
			ShowSpinner(1, 100)
			flaskState = 1
		elseif GetSpriteHitTest(shuffleButton, GetPointerX(), GetPointerY()) = 1
			// Shuffle amoebas.
			ShuffleFlask(flasks[selectedFlask])
			RefreshFlaskAmoebaButtons(1)
		elseif GetSpriteHitTest(returnFlaskButton, GetPointerX(), GetPointerY()) = 1
			// Return screen.
			SetFlaskScreenVisible(0)
			SetLabScreenVisible(1)
		else
			for i = 1 to amoebaButtons.length
				if GetSpriteHitTest(amoebaButtons[i], GetPointerX(), GetPointerY()) = 1
					// Select amoeba.
					SetSelectedAmoeba(i)
					SetFlaskScreenVisible(0)
					SetAmoebaScreenVisible(1)
				endif
			next i
		endif
	endif
endfunction
