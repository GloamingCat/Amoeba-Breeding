
// =================================================================================================
// Flask Screen
// =================================================================================================

// Flask ID.
global selectedFlask as integer = -1
function SetSelectedFlask(id as integer)
	selectedFlask = id
endfunction

// Radiation button
global radiationButton as integer
radiationButton = CreateSprite(0)
SetSpritePosition(radiationButton, GetVirtualWidth() / 2 - 50, GetVirtualHeight() - 150)
SetSpriteColor(radiationButton, 255, 255, 0, 255)
SetSpriteSize(radiationButton, 100, 100)
SetSpriteVisible(radiationButton, 0)

// =================================================================================================
// Visibility
// =================================================================================================

// Show / hide buttons.
function SetFlaskScreenVisible(visible as integer)
	SetSpriteVisible(radiationButton, visible)
	if visible then state = 2
endfunction

// =================================================================================================
// Check Input
// =================================================================================================

function FlaskScreen()
	Print("Flask")
	if GetPointerPressed() = 1
		
	endif
endfunction
