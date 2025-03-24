-- DEFINE COMMAND TO BROADCAST MESSAGE ACROSS LFG CHANNELS

local function joinChannels()
    JoinChannelByName("World")
    JoinChannelByName("LookingForGroup")
end

local function broadcastMessage(message)
    SendChatMessage(message, "CHANNEL", nil, GetChannelName("World"))
    SendChatMessage(message, "CHANNEL", nil, GetChannelName("LookingForGroup"))
end

local function handleLfgCommand(msg)
    if msg and msg ~= "" then
        joinChannels()
        broadcastMessage(msg)
    end
end

SLASH_LFG1 = "/lfg"
SlashCmdList["LFG"] = handleLfgCommand