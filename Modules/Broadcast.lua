-- LFG CHANNEL BROADCAST FEATURE

local function joinLfgChannels()
    JoinChannelByName("World")
    JoinChannelByName("LookingForGroup")
end

local function broadcastToLfgChannels(lfgMessage)
    SendChatMessage(lfgMessage, "CHANNEL", nil, GetChannelName("World"))
    SendChatMessage(lfgMessage, "CHANNEL", nil, GetChannelName("LookingForGroup"))
end

local function sendLFG(lfgMessage)
    if lfgMessage and lfgMessage ~= "" then
        joinLfgChannels()
        broadcastToLfgChannels(lfgMessage)
    end
end

SLASH_LFG1 = "/lfg"
SlashCmdList["LFG"] = sendLFG