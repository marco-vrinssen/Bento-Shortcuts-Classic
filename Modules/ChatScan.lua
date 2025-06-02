-- INITIALIZE KEYWORD STORAGE

local activeKeywordFilters = {}

-- NOTIFICATION ON KEYWORD MATCH

local function notifyKeywordMatch(matchedMessage, matchedSender)
    local senderLink = "|Hplayer:" .. matchedSender .. "|h" .. YELLOW_LIGHT_LUA .. "[" .. matchedSender .. "]:|r|h"
    print(senderLink .. " " .. matchedMessage)
    PlaySound(3175, "Master", true)
end

-- KEYWORD FILTERING LOGIC

local function doesMessageMatchAnyKeywordFilter(chatMessage)
    local lowerMessage = strlower(chatMessage)
    for i = 1, #activeKeywordFilters do
        if strfind(lowerMessage, strlower(activeKeywordFilters[i]), 1, true) then
            return true
        end
    end
    return false
end

-- EVENT HANDLER FOR CHAT MESSAGE SCANNING

local function handleChatMessageEvent(_, _, chatMessage, senderName, _, channelName, ...)
    if #activeKeywordFilters > 0 and strmatch(channelName, "%d+") then
        local channelNumber = tonumber(strmatch(channelName, "%d+"))
        if channelNumber and channelNumber >= 1 and channelNumber <= 20 and doesMessageMatchAnyKeywordFilter(chatMessage) then
            notifyKeywordMatch(chatMessage, senderName)
        end
    end
end

-- SETUP CHAT EVENT FRAME

local chatScanEventFrame = CreateFrame("Frame")
chatScanEventFrame:SetScript("OnEvent", handleChatMessageEvent)

-- SLASH COMMAND HANDLER FOR KEYWORD SCANNING

local function handleScanSlashCommand(commandInput)
    local trimmedInput = commandInput:gsub("^%s*(.-)%s*$", "%1")
    if trimmedInput == "" or trimmedInput == "stop" or trimmedInput == "clear" then
        wipe(activeKeywordFilters)
        print(YELLOW_LIGHT_LUA .. "[Chat Scan]:|r Stopped and cleared.")
        chatScanEventFrame:UnregisterEvent("CHAT_MSG_CHANNEL")
    else
        if not chatScanEventFrame:IsEventRegistered("CHAT_MSG_CHANNEL") then
            chatScanEventFrame:RegisterEvent("CHAT_MSG_CHANNEL")
        end
        table.insert(activeKeywordFilters, trimmedInput)
        local keywordString = table.concat(activeKeywordFilters, " / ")
        print(YELLOW_LIGHT_LUA .. "[Chat Scan]:|r " .. keywordString)
    end
end

SLASH_SCAN1 = "/scan"
SlashCmdList["SCAN"] = handleScanSlashCommand