-- Moved the below comment above the function for better clarity
-- this method is supposed to print names of all guilds that have less than memberCount max members
function printSmallGuildNames(memberCount)
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
    -- I'm assuming 'db' is declared globally somewhere else
    local resultId = db.storeQuery(string.format(selectGuildQuery, memberCount))
    -- Corrected 'result' to the variable 'resultId'
    local guildName = resultId.getString("name")
    print(guildName)
end