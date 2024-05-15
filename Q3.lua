-- Renamed the function for clarity based on what the function seems to be doing
-- Seems like this method gets the player and target party member, searches for that party member,
-- and removes them from the player's party
function removeMemberFromParty(playerId, membername)
    -- Made this local because we're only using it here
    local player = Player(playerId)
    local party = player:getParty()
    -- Defined member name as a variable because it is being used multiple times; makes it easier to change later
    -- Made an assumption that you can pass a name into Player() as well as an ID
    local targetMember = Player(membername)
    
    -- It seems like getMembers() would return the PID and name, but the function takes the member name
    -- If that's the case, it may be better to check against the PID instead of the name if names aren't unique
    for k,v in pairs(party:getMembers()) do
        if v == targetMember then
            party:removeMember(targetMember)
        end
    end
end