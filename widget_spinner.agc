
// TODO

global spinnerValue as integer = -1
global spinnerMin as integer = -1
global spinnerMax as integer = -1

function ShowSpinner(min as integer, max as integer)
	spinnerMin = min
	spinnerMax = max
	StartTextInput()
endfunction

function UpdateSpinner()
	waiting = 1
	if GetTextInputCompleted() = 1
		spinnerValue = Val(GetTextInput())
	elseif GetTextInputCancelled() = 1
		waiting = 0
	endif
endfunction waiting

function CloseSpinner()
	spinnerValue = -1
endfunction
