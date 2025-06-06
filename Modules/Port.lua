-- Create port command handler to find teleport providers

local function handlePortCommand(targetZone)
    local playerMaxLevel = GetMaxPlayerLevel()
    
    if targetZone ~= "" then
        C_FriendList.SendWho("z-" .. targetZone .. " c-warlock 24-" .. playerMaxLevel)
    else
        local currentZone = GetRealZoneText()
        C_FriendList.SendWho("z-" .. currentZone .. " c-mage 40-" .. playerMaxLevel)
    end
end

-- Register slash command for port functionality

SLASH_PORT1 = "/port"
SlashCmdList["PORT"] = handlePortCommand