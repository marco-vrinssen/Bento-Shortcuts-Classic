-- Join LFG channels to enable message broadcasting

local function joinLfgChannels()
    JoinChannelByName("World")
    JoinChannelByName("LookingForGroup")
end

-- Broadcast message to increase LFG visibility

local function broadcastMessage(message)
    SendChatMessage(message, "CHANNEL", nil, GetChannelName("World"))
    SendChatMessage(message, "CHANNEL", nil, GetChannelName("LookingForGroup"))
end

-- Handle input to trigger broadcast functionality

local function handleInput(message)
    if message and message ~= "" then
        joinLfgChannels()
        broadcastMessage(message)
    end
end

-- Register command to invoke broadcast handler

SLASH_LFG1 = "/lfg"
SlashCmdList["LFG"] = handleInput