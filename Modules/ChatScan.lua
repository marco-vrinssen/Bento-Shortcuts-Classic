-- INITIALIZE VARIABLES

local keywordTable = {}
local playerName = UnitName("player")

-- NOTIFICATION FUNCTIONS

local function keywordMatch(msg, senderName)
    local playerLink = "|Hplayer:" .. senderName .. "|h" .. YELLOW_CHAT_LUA .. "[" .. senderName .. "]: " .. "|r" .. "|h"
    print(playerLink .. msg)
    PlaySound(3175, "Master", true)
end

-- KEYWORD MATCHING LOGIC

local function keywordFilter(msg)
    for _, keywordSet in ipairs(keywordTable) do
        if type(keywordSet) == "string" then
            local pattern = strlower(keywordSet)
            if strfind(strlower(msg), pattern) then
                return true
            end
        elseif type(keywordSet) == "table" then
            local allMatch = true
            for _, keyword in ipairs(keywordSet) do
                local pattern = strlower(keyword)
                if not strfind(strlower(msg), pattern) then
                    allMatch = false
                    break
                end
            end
            if allMatch then
                return true
            end
        end
    end
    return false
end

-- EVENT HANDLING

local function keywordValidation(self, event, msg, senderName, languageName, channelName, ...)
    if next(keywordTable) and strmatch(channelName, "%d+") then
        local channelNumber = tonumber(strmatch(channelName, "%d+"))
        if channelNumber and channelNumber >= 1 and channelNumber <= 20 and keywordFilter(msg) then
            keywordMatch(msg, senderName)
        end
    end
end

-- FRAME SETUP

local filterCommandEvents = CreateFrame("Frame")
filterCommandEvents:SetScript("OnEvent", keywordValidation)

-- SLASH COMMAND HANDLER

local function handleFilterCommand(msg)
    if msg == "" or msg == "stop" or msg == "clear" then
        wipe(keywordTable)
        print(YELLOW_CHAT_LUA .. "Scanning stopped.")
        filterCommandEvents:UnregisterEvent("CHAT_MSG_CHANNEL")
    else
        if not filterCommandEvents:IsEventRegistered("CHAT_MSG_CHANNEL") then
            filterCommandEvents:RegisterEvent("CHAT_MSG_CHANNEL")
        end

        table.insert(keywordTable, msg)

        local newKeywordsStr = ""
        for i, keywordSet in ipairs(keywordTable) do
            newKeywordsStr = newKeywordsStr .. "\"" .. keywordSet .. "\""
            if i ~= #keywordTable then
                newKeywordsStr = newKeywordsStr .. ", "
            end
        end
        print(YELLOW_CHAT_LUA .. "Scanning all channels for" .. "|r" .. " " .. newKeywordsStr:gsub('"', '') .. ".")
    end
end

SLASH_SCAN1 = "/scan"
SlashCmdList["SCAN"] = handleFilterCommand