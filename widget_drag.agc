
// =================================================================================================
// Drag-n-Drop Button Type
// =================================================================================================

type DragButton
	sprite as integer
	targets as integer[]
	x as float
	y as float
	xstart as float
	ystart as float
	xend as float
	yend as float
	wait as integer
	state as integer
endtype

// Checks if button was grabbed and update drag information.
function OnDragButtonPress(drag ref as DragButton)
	dragged as integer
	if GetSpriteHitTest(drag.sprite, getPointerX(), getPointerY()) = 1 and GetSpriteVisible(drag.sprite)
		drag.wait = 10
		drag.state = 1
		dragged = 1
		drag.xstart = GetPointerX() - drag.x
		drag.ystart = GetPointerY() - drag.y
	else
		drag.state = 0
		dragged = 0
	endif
endfunction dragged

// Updates waiting time.
function OnDragButtonHold(drag ref as DragButton)
	ended as integer
	ended = 0
	drag.xend = GetPointerX()
	drag.yend = GetPointerY()
	if drag.state = 1
		if drag.wait > 0
			drag.wait = drag.wait - 1
		else
			drag.state = 2
			ended = 1
		endif
	elseif drag.state = 2
		SetSpritePosition(drag.sprite, drag.xend - drag.xstart, drag.yend - drag.ystart)
	endif
endfunction ended

// Checks if button was dropped and update drag information. Returns the index of target dropped, if any.
function OnDragButtonDrop(drag ref as DragButton)
	SetSpritePosition(drag.sprite, drag.x, drag.y)
	dropped as integer
	if drag.state = 0
		dropped = -1
	else
		drag.state = 0
		if drag.state = 2
			for i = 1 to drag.targets.length
				if GetSpriteHitTest(drag.targets[i], drag.xend, drag.yend) = 1
					dropped = i
				endif
			next i
		endif
	endif
endfunction dropped
