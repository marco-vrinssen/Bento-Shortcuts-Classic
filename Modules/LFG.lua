local function JoinChannels()
    JoinChannelByName("World")
    JoinChannelByName("LookingForGroup")
end

local function BroadcastMessage(message)
    SendChatMessage(message, "CHANNEL", nil, GetChannelName("World"))
    SendChatMessage(message, "CHANNEL", nil, GetChannelName("LookingForGroup"))
end

SLASH_LFG1 = "/lfg"
SlashCmdList["LFG"] = function(msg)
    if msg and msg ~= "" then
        JoinChannels()
        BroadcastMessage(msg)
    end
end
