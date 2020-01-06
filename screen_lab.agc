
// =================================================================================================
// Lab Screen
// =================================================================================================

// Flask Buttons
global flaskButtons as integer [4]
for i = 1 to 4
	flaskButtons[i] = CreateSprite(0)
	SetSpritePosition(flaskButtons[i], ((i + 1) / 2 - 1.5) * 300 + GetVirtualWidth() / 2 - 125, 300 * mod(i, 2) + 300)
	SetSpriteColor(flaskButtons[i], 0, 255, 255, 255)
	SetSpriteSize(flaskButtons[i], 250, 250)
	SetSpriteVisible(flaskButtons[i], 0)
next i

// Coin Button
global coinButton as integer
coinButton = CreateSprite(0)
SetSpritePosition(coinButton, -300 + GetVirtualWidth() / 2 - 50, GetVirtualHeight() - 150)
SetSpriteColor(coinButton, 0, 0, 255, 255)
SetSpriteSize(coinButton, 100, 100)
SetSpriteVisible(coinButton, 0)

// Food button
global foodButton as DragButton
foodButton.x = GetVirtualWidth() / 2 - 50
foodButton.y = GetVirtualHeight() - 150
foodButton.sprite = CreateSprite(0)
foodButton.targets = flaskButtons
SetSpritePosition(foodButton.sprite, foodButton.x, foodButton.y)
SetSpriteColor(foodButton.sprite, 0, 255, 0, 255)
SetSpriteSize(foodButton.sprite, 100, 100)
SetSpriteVisible(foodButton.sprite, 0)

// Hand Button
global handButton as DragButton
handButton.x = 300 + GetVirtualWidth() / 2 - 50
handButton.y = GetVirtualHeight() - 150
handButton.sprite = CreateSprite(0)
handButton.targets = flaskButtons
SetSpritePosition(handButton.sprite, handButton.x, handButton.y)
SetSpriteColor(handButton.sprite, 255, 0, 0, 255)
SetSpriteSize(handButton.sprite, 100, 100)
SetSpriteVisible(handButton.sprite, 0)

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
	SetSpriteVisible(handButton.sprite, visible and storedAmoeba.genes.length > 0)
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
			SetCoinScreenVisible(1)
		else
			// Drag button.
			OnDragButtonPress(foodButton)
			OnDragButtonPress(handButton)
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
		target = OnDragButtonDrop(handButton)
		if target >= 0
			// Drop amoeba.
			SetSelectedFlask(target)
			ShowConfirm()
			labState = 2
		endif
	else
		OnDragButtonHold(foodButton)
		OnDragButtonHold(handButton)
	endif
endfunction
