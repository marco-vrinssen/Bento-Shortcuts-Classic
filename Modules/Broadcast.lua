-- Add LFG channel broadcast feature for group finding

-- Join LFG channels World and LookingForGroup for message broadcast
local function joinLfgChannels()
    JoinChannelByName("World")
    JoinChannelByName("LookingForGroup")
end

-- Broadcast message to both LFG channels for visibility
local function broadcastLfgMessage(lfgMsg)
    SendChatMessage(lfgMsg, "CHANNEL", nil, GetChannelName("World"))
    SendChatMessage(lfgMsg, "CHANNEL", nil, GetChannelName("LookingForGroup"))
end

-- Handle LFG message input and trigger broadcast logic
local function handleLfgInput(lfgMsg)
    if lfgMsg and lfgMsg ~= "" then
        joinLfgChannels()
        broadcastLfgMessage(lfgMsg)
    end
end

-- Register /lfg command to invoke LFG broadcast handler
SLASH_LFG1 = "/lfg"
SlashCmdList["LFG"] = handleLfgInput