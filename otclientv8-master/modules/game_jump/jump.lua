jumpWindow = nil
jumpMenuButton = nil
jumpWindowButton = nil

local moveDistance = 0
local wrapDistance = 0
local roofDistance = 0
local loopEvent = nil

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

function terminate()
    disconnect(g_game, {
        onGameStart = online,
        onGameEnd = offline
    })

    jumpWindow:destroy()
    jumpMenuButton:destroy()
end

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

function moveButton()
    if jumpWindow:isVisible() then
        moveDistance = jumpWindowButton:getMarginRight()
        if moveDistance >= wrapDistance then
            moveDistance = 0
            resetButton()
        else
            moveDistance = moveDistance + 10
            jumpWindowButton:setMarginRight(moveDistance)
        end
    end
end

function resetButton()
    jumpWindowButton:setMarginBottom(math.random(0, roofDistance))
    jumpWindowButton:setMarginRight(0)
end