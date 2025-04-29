-- INITIALIZE KEYWORD STORAGE AND PLAYER NAME

local activeKeywordFilters = {}
local localPlayerName = UnitName("player")

-- NOTIFICATION ON KEYWORD MATCH

local function notifyKeywordMatch(matchedMessage, matchedSender)
    local senderLink = "|Hplayer:" .. matchedSender .. "|h" .. YELLOW_CHAT_LUA .. "[" .. matchedSender .. "]: " .. "|r" .. "|h"
    print(senderLink .. matchedMessage)
    PlaySound(3175, "Master", true)
end

-- KEYWORD FILTERING LOGIC

local function doesMessageMatchAnyKeywordFilter(chatMessage)
    for _, keywordFilter in ipairs(activeKeywordFilters) do
        if type(keywordFilter) == "string" then
            local keywordPattern = strlower(keywordFilter)
            if strfind(strlower(chatMessage), keywordPattern) then
                return true
            end
        elseif type(keywordFilter) == "table" then
            local allKeywordsPresent = true
            for _, requiredKeyword in ipairs(keywordFilter) do
                local keywordPattern = strlower(requiredKeyword)
                if not strfind(strlower(chatMessage), keywordPattern) then
                    allKeywordsPresent = false
                    break
                end
            end
            if allKeywordsPresent then
                return true
            end
        end
    end
    return false
end

-- EVENT HANDLER FOR CHAT MESSAGE SCANNING

local function handleChatMessageEvent(self, event, chatMessage, senderName, languageName, channelName, ...)
    if next(activeKeywordFilters) and strmatch(channelName, "%d+") then
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
        print(BentoChatColors.YELLOW_LUA .. "[CHAT SCAN]:" .. "|r " .. BentoChatColors.WHITE_LUA .. "Stopped and cleared.|r")
        chatScanEventFrame:UnregisterEvent("CHAT_MSG_CHANNEL")
    else
        if not chatScanEventFrame:IsEventRegistered("CHAT_MSG_CHANNEL") then
            chatScanEventFrame:RegisterEvent("CHAT_MSG_CHANNEL")
        end

        local keywordList = {}
        for keyword in string.gmatch(trimmedInput, '([^,]+)') do
            local cleanedKeyword = keyword:gsub("^%s*(.-)%s*$", "%1")
            if cleanedKeyword ~= "" then
                table.insert(keywordList, cleanedKeyword)
            end
        end

        if #keywordList == 1 then
            table.insert(activeKeywordFilters, keywordList[1])
        elseif #keywordList > 1 then
            table.insert(activeKeywordFilters, keywordList)
        end

        local groupedKeywordStrings = {}
        for _, keywordFilter in ipairs(activeKeywordFilters) do
            if type(keywordFilter) == "string" then
                table.insert(groupedKeywordStrings, WHITE_CHAT_LUA .. keywordFilter .. "|r")
            elseif type(keywordFilter) == "table" then
                local coloredKeywords = {}
                for i, kw in ipairs(keywordFilter) do
                    table.insert(coloredKeywords, WHITE_CHAT_LUA .. kw .. "|r")
                end
                table.insert(groupedKeywordStrings, table.concat(coloredKeywords, YELLOW_CHAT_LUA .. " AND " .. "|r"))
            end
        end
        print(BentoChatColors.YELLOW_LUA .. "[CHAT SCAN]:" .. "|r " .. table.concat(groupedKeywordStrings, BentoChatColors.YELLOW_LUA .. " / " .. "|r"))
    end
end

SLASH_SCAN1 = "/scan"
SlashCmdList["SCAN"] = handleScanSlashCommand