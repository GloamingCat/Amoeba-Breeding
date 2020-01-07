
// =================================================================================================
// Amoeba Breeding
// =================================================================================================

// =================================================================================================
// Settings
// =================================================================================================

// Show all errors.
SetErrorMode(2)

// Set window properties.
SetWindowTitle("Amoeba Breeding")
SetWindowSize(GetMaxDeviceWidth(), GetMaxDeviceHeight(), 0)
SetWindowAllowResize(0) // allow the user to resize the window

// Set display properties.
SetVirtualResolution(GetMaxDeviceWidth(), GetMaxDeviceHeight()) // Doesn't have to match the window.
SetOrientationAllowed(1, 1, 0, 0) // Allow portrait on mobile devices.
SetSyncRate(20, 0) // 20fps instead of 60 to save battery.
SetScissor(0, 0, 0, 0) // Use the maximum available screen space, no black borders.
UseNewDefaultFonts(1) // Since version 2.0.22 we can use nicer default fonts.

// =================================================================================================
// Import Files
// =================================================================================================

#insert "graphics.agc"
#insert "data_amoeba.agc"
#insert "data_simulation.agc"
#insert "data_game.agc"
#insert "widget_drag.agc"
#insert "widget_spinner.agc"
#insert "widget_confirm.agc"
#insert "screen_lab.agc"
#insert "screen_coin.agc"
#insert "screen_hand.agc"
#insert "screen_flask.agc"
#insert "screen_amoeba.agc"

// =================================================================================================
// Main Loop
// =================================================================================================

LoadGame()
global state as integer = -1
SetLabScreenVisible(1)
do
	if state = 0
		LabScreen()
	elseif state = 1
		CoinScreen()
	elseif state = 2
		HandScreen()
	elseif state = 3
		FlaskScreen()
	elseif state = 4
		AmoebaScreen()
	endif
    Sync()
loop
