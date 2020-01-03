
// Project: Test 
// Created: 2019-12-18

// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle("Test")
SetWindowSize(GetMaxDeviceWidth(), GetMaxDeviceHeight(), 0)
SetWindowAllowResize(0) // allow the user to resize the window


// set display properties
SetVirtualResolution(GetMaxDeviceWidth(), GetMaxDeviceHeight()) // doesn't have to match the window
SetOrientationAllowed(1, 1, 0, 0) // allow both portrait and landscape on mobile devices
SetSyncRate(30, 0) // 30fps instead of 60 to save battery
SetScissor(0, 0, 0, 0) // use the maximum available screen space, no black borders
UseNewDefaultFonts(1) // since version 2.0.22 we can use nicer default fonts

// this example should work with AGK V1 and V2

//bg=CreateSprite(0)
//SetSpriteColor(bg,0,255,0,255)
//SetSpriteSize(bg,1024,768)

// create object plane
// without any further code the plane will be position at 0,0,0 and have a rotation of 0,0,0
// the rotation of 0,0,0 means that it will be parrallel with xy plane
//plane = CreateObjectPlane(100,50)
//SetObjectColor(plane, 255, 0, 255, 255)

// create a directional light (to make the scene look better)
//CreateLightDirectional(1,-1,-1,1,255,255,255)

#insert "amoeba.agc"
#insert "simulation.agc"
#insert "game.agc"
#insert "drag.agc"
#insert "spinner.agc"
#insert "confirm.agc"
#insert "lab.agc"
#insert "coin.agc"
#insert "flask.agc"

// position and orientate the camera
//SetCameraPosition(1, 0, 0, -100)
//SetCameraLookAt(1, 0, 0, 0, 0)
//obj = LoadObject ("Amoeba.obj")
//shader = LoadShader("vertex.glsl", "pixel.glsl")
//SetObjectShader(obj, shader)
//SetObjectPosition(obj, 0, 0, -10)
//SetObjectScale(obj, 10, 10, 10)
//SetObjectRotation(obj, 90, 0, 0)

global state as integer = -1
SetLabScreenVisible(1)
do
	Print(state)
	if state = 0
		LabScreen()
	elseif state = 1
		CoinScreen()
	elseif state = 2
		FlaskScreen()
	endif
    //Print(Str(GetMaxDeviceWidth()) + "," + Str(GetMaxDeviceHeight()))
    Sync()
loop


