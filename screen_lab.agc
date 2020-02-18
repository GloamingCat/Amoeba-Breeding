
// =================================================================================================
// Lab Screen
// =================================================================================================

// Flask Buttons
global flaskButtons as integer [4]
flaskImg = LoadImage("Flask.png")
for i = 1 to 4
	flaskButtons[i] = CreateSprite(flaskImg)
	SetSpritePosition(flaskButtons[i], ((i + 1) / 2 - 1.5) * 300 + GetVirtualWidth() / 2 - 125, 300 * mod(i, 2) + 200)
	SetSpriteVisible(flaskButtons[i], 0)
next i

// Coin Button
global coinButton as integer
coinImg = LoadImage("Coin.png")
coinButton = CreateSprite(coinImg)
SetSpritePosition(coinButton, 192, GetVirtualHeight() - 192)
SetSpriteVisible(coinButton, 0)

// Food button
global foodButton as DragButton
foodImg = LoadImage("Food.png")
foodButton.sprite = CreateSprite(foodImg)
foodButton.x = GetVirtualWidth() / 2 - 64
foodButton.y = GetVirtualHeight() - 192
foodButton.targets = flaskButtons
SetSpritePosition(foodButton.sprite, foodButton.x, foodButton.y)
SetSpriteVisible(foodButton.sprite, 0)

// Hand Button
global handButton as integer
handImg = LoadImage("Bottle.png")
handButton = CreateSprite(handImg)
SetSpritePosition(handButton, GetVirtualWidth() - 192 - 128, GetVirtualHeight() - 192)
SetSpriteVisible(handButton, 0)

// State
// 0 => Nothing open.
// 1 => Food spinner open.
// 2 => Confirm window open.
labState as integer = 0

// =================================================================================================
// Visibility
// =================================================================================================

// Show / hide buttons.
function SetLabScreenVisible(visible as integer)
	for i = 1 to 4
		SetSpriteVisible(flaskButtons[i], visible)
	next i
	SetSpriteVisible(coinButton, visible)
	SetSpriteVisible(foodButton.sprite, visible)
	SetSpriteVisible(handButton, visible)
	if visible then state = 0
endfunction

// =================================================================================================
// Input Check
// =================================================================================================

// Check lab state.
function LabScreen()
	Print("Lab")
	if labState = 0
		//Nothing open.
		CheckLabButtons()
	elseif labState = 1
		// Food spinner open.
		if spinnerValue = -1
			if UpdateSpinner() = 0
				CloseSpinner()
				labState = 0
			endif
		else
			FeedFlask(flasks[selectedFlask], spinnerValue)
			CloseSpinner()
			labState = 0
		endif
	elseif labState = 2
		// Confirm window open.
		if confirmed = -1
			if UpdateConfirm() = 0
				CloseConfirm()
				labState = 0
			endif
		else
			CloseConfirm()
			labState = 0
			DropAmoeba(flasks[selectedFlask])
		endif
	endif
endfunction

// Check button input.
function CheckLabButtons()
	if GetPointerPressed() = 1
		for i = 1 to 4
			if GetSpriteHitTest(flaskButtons[i], GetPointerX(), GetPointerY()) = 1
				// Open Flask screen.
				SetSelectedFlask(i)
				SetLabScreenVisible(0)
				SetFlaskScreenVisible(1)
			endif
		next i
		if GetSpriteHitTest(coinButton, GetPointerX(), GetPointerY()) = 1
			// Open Lab screen.
			SetLabScreenVisible(0)
			SetHandScreenVisible(1)
		elseif GetSpriteHitTest(handButton, GetPointerX(), GetPointerY()) = 1
			SetLabScreenVisible(0)
			SetCoinScreenVisible(1)
		else
			// Drag button.
			OnDragButtonPress(foodButton)
		endif
	elseif GetPointerReleased() = 1 
		// Drop button.
		local target as integer
		target = OnDragButtonDrop(foodButton)
		if target >= 0
			// Drop food.
			SetSelectedFlask(target)
			ShowSpinner(1, remainingFood)
			labState = 1
		endif
	else
		OnDragButtonHold(foodButton)
	endif
endfunction
