-- Window Variables
jumpWindow = nil
jumpMenuButton = nil
jumpWindowButton = nil

-- Jump button variables
local moveDistance = 0
local wrapDistance = 0
local roofDistance = 0
local loopEvent = nil

-- Initiates the creation of the module
function init()
    connect(g_game, {
        onGameStart = online,
        onGameEnd = offline
    })

    jumpMenuButton = modules.client_topmenu.addRightGameToggleButton('jumpMenuButton', tr('Jump'), '/images/topbuttons/hotkeys', toggle)
    jumpMenuButton:setOn(false)

    jumpWindow = g_ui.displayUI('jump', modules.game_interface.getRightPanel())
    jumpWindow:hide()
    wrapDistance = jumpWindow:getWidth() - 100
    roofDistance = jumpWindow:getHeight() - 50

    jumpWindowButton = jumpWindow:getChildById('buttonJump')
end

-- Terminates the module components on exit
function terminate()
    disconnect(g_game, {
        onGameStart = online,
        onGameEnd = offline
    })

    jumpWindow:destroy()
    jumpMenuButton:destroy()
end

-- Opens and closes the window and starts the astops the button movement
function toggle()
    if jumpMenuButton:isOn() then
        jumpMenuButton:setOn(false)
        jumpWindow:hide()
        removeEvent(loopEvent)
        resetButton()
    else
        jumpMenuButton:setOn(true)
        jumpWindow:show()
        jumpWindow:raise()
        jumpWindow:focus()
        loopEvent = cycleEvent(moveButton, 100)
    end
end

-- Moves the button from right to left and wraps back around
function moveButton()
    if jumpWindow:isVisible() then
        moveDistance = jumpWindowButton:getMarginRight()
        -- Wrap back to start
        if moveDistance >= wrapDistance then
            moveDistance = 0
            resetButton()
        -- Move left
        else
            moveDistance = moveDistance + 10
            jumpWindowButton:setMarginRight(moveDistance)
        end
    end
end

-- Resets the button back to the right and to a random height 
function resetButton()
    jumpWindowButton:setMarginBottom(math.random(0, roofDistance))
    jumpWindowButton:setMarginRight(0)
end