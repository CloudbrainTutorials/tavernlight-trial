
-- Seems to release whatever is stored in slot id 1000
-- Added slotId parameter to match what as in onLogout method
-- Otherwise it we could remove the second parameter of the addEvent call as it doesn't seem to used
-- Added the new parameter in the first position because it is given before 'player' in the call to addEvent
local function releaseStorage(slotId, player)
    player:setStorageValue(slotId, -1)
end

-- Confirms if releasing the object at slot 1000 was successful on logout
function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        addEvent(releaseStorage, 1000, player)
        -- Moved return statement into here so I could add an else statement
        return true
    -- Added an else condition for if the storage value isn't 1
    else
        return false
    end
end