-- CREATE /port COMMAND

local function portCommand(msg)
    local zone = msg
    local maxLevel = GetMaxPlayerLevel()
    
    if zone ~= "" then
        C_FriendList.SendWho("z-" .. zone .. " c-warlock 24-" .. maxLevel)
    else
        zone = GetRealZoneText()
        C_FriendList.SendWho("z-" .. zone .. " c-mage 40-" .. maxLevel)
    end
end

SLASH_TRAVEL1 = "/travel"
SlashCmdList["TRAVEL"] = portCommand