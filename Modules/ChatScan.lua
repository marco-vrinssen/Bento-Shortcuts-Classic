-- Initialize keywordFilters for storing active filters

local keywordFilters = {}

-- Define notifyKeywordMatch to alert on keyword match

local function notifyKeywordMatch(matchedMsg, matchedSender)
    local senderLink = "|Hplayer:" .. matchedSender .. "|h" .. YELLOW_LIGHT_LUA .. "[" .. matchedSender .. "]:|r|h"
    print(senderLink .. " " .. matchedMsg)
    PlaySound(3175, "Master", true)
end

-- Define doesMessageMatchKeyword to check for keyword presence

local function doesMessageMatchKeyword(chatMsg)
    local lowerMsg = strlower(chatMsg)
    for i = 1, #keywordFilters do
        if strfind(lowerMsg, strlower(keywordFilters[i]), 1, true) then
            return true
        end
    end
    return false
end

-- Define handleChatMsgEvent to process chat messages

local function handleChatMsgEvent(_, _, chatMsg, senderName, _, channelName, ...)
    if #keywordFilters > 0 and strmatch(channelName, "%d+") then
        local channelNum = tonumber(strmatch(channelName, "%d+"))
        if channelNum and channelNum >= 1 and channelNum <= 20 and doesMessageMatchKeyword(chatMsg) then
            notifyKeywordMatch(chatMsg, senderName)
        end
    end
end

-- Initialize chatScanFrame for event handling

local chatScanFrame = CreateFrame("Frame")
chatScanFrame:SetScript("OnEvent", handleChatMsgEvent)

-- Define handleScanCmd to manage slash command input

local function handleScanCmd(cmdInput)
    local trimmedInput = cmdInput:gsub("^%s*(.-)%s*$", "%1")
    if trimmedInput == "" or trimmedInput == "stop" or trimmedInput == "clear" then
        wipe(keywordFilters)
        print(YELLOW_LIGHT_LUA .. "[Chat Scan]:|r Stopped and cleared.")
        chatScanFrame:UnregisterEvent("CHAT_MSG_CHANNEL")
    else
        if not chatScanFrame:IsEventRegistered("CHAT_MSG_CHANNEL") then
            chatScanFrame:RegisterEvent("CHAT_MSG_CHANNEL")
        end
        table.insert(keywordFilters, trimmedInput)
        local keywordStr = table.concat(keywordFilters, " / ")
        print(YELLOW_LIGHT_LUA .. "[Chat Scan]:|r " .. keywordStr)
    end
end

-- Register /scan slash command for chat scanning

SLASH_SCAN1 = "/scan"
SlashCmdList["SCAN"] = handleScanCmd