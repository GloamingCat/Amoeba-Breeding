
// =================================================================================================
// Amoeba Breeding
// =================================================================================================

#insert "amoeba.agc"
#insert "simulation.agc"
#insert "game.agc"
#insert "drag.agc"
#insert "spinner.agc"
#insert "confirm.agc"
#insert "lab.agc"
#insert "coin.agc"
#insert "flask.agc"

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
// Main Loop
// =================================================================================================

global state as integer = -1
SetLabScreenVisible(1)
do
	if state = 0
		LabScreen()
	elseif state = 1
		CoinScreen()
	elseif state = 2
		FlaskScreen()
	endif
    Sync()
loop
