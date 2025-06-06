-- Extract whisper parameters from command string for flexible messaging

local function extractWhisperParams(cmdString)
    local playerLimit, excludedClass, msgContent
    playerLimit, excludedClass, msgContent = cmdString:match("^(%d+)%s*-%s*(%w+)%s+(.+)$")
    if not playerLimit then
        playerLimit, msgContent = cmdString:match("^(%d+)%s+(.+)$")
        if not playerLimit then
            excludedClass, msgContent = cmdString:match("^%-(%w+)%s+(.+)$")
            if not excludedClass then
                msgContent = cmdString
            end
        end
    end
    return playerLimit, excludedClass, msgContent
end

-- Broadcast message to who results with optional filtering

local function broadcastWhoList(cmdString)
    local playerLimit, excludedClass, msgContent = extractWhisperParams(cmdString)
    local whoResultCount = C_FriendList.GetNumWhoResults()
    if playerLimit then
        playerLimit = tonumber(playerLimit)
    else
        playerLimit = whoResultCount
    end
    if excludedClass then
        excludedClass = excludedClass:lower()
    end
    if msgContent and msgContent ~= "" and whoResultCount and whoResultCount > 0 then
        local sentMsgCount = 0
        for i = 1, whoResultCount do
            if sentMsgCount >= playerLimit then break end
            local playerInfo = C_FriendList.GetWhoInfo(i)
            if playerInfo and playerInfo.fullName then
                if excludedClass then
                    if playerInfo.classStr:lower() ~= excludedClass then
                        SendChatMessage(msgContent, "WHISPER", nil, playerInfo.fullName)
                        sentMsgCount = sentMsgCount + 1
                    end
                else
                    SendChatMessage(msgContent, "WHISPER", nil, playerInfo.fullName)
                    sentMsgCount = sentMsgCount + 1
                end
            end
        end
    end
end

SLASH_MULTIWHISPER1 = "/w+"
SlashCmdList["MULTIWHISPER"] = broadcastWhoList

-- Initialize spam database to prevent duplicate messages

local function initSpamDb()
    if not BentoShortcutsClassicDB then
        BentoShortcutsClassicDB = {}
    end
    if type(BentoShortcutsClassicDB.MultiWhisperIgnore) ~= "table" then
        BentoShortcutsClassicDB.MultiWhisperIgnore = {}
    end
end

-- Broadcast message while tracking sent players to prevent spam

local function broadcastSkipSent(cmdString)
    initSpamDb()
    local playerLimit, excludedClass, msgContent = extractWhisperParams(cmdString)
    local whoResultCount = C_FriendList.GetNumWhoResults()
    if playerLimit then
        playerLimit = tonumber(playerLimit)
    else
        playerLimit = whoResultCount
    end
    if excludedClass then
        excludedClass = excludedClass:lower()
    end
    if msgContent and msgContent ~= "" and whoResultCount and whoResultCount > 0 then
        local sentMsgCount = 0
        for i = 1, whoResultCount do
            if sentMsgCount >= playerLimit then break end
            local playerInfo = C_FriendList.GetWhoInfo(i)
            if playerInfo and playerInfo.fullName then
                local playerKey = playerInfo.fullName
                if excludedClass then
                    if playerInfo.classStr:lower() ~= excludedClass then
                        if not BentoShortcutsClassicDB.MultiWhisperIgnore[playerKey] then
                            SendChatMessage(msgContent, "WHISPER", nil, playerInfo.fullName)
                            BentoShortcutsClassicDB.MultiWhisperIgnore[playerKey] = true
                            sentMsgCount = sentMsgCount + 1
                        end
                    end
                else
                    if not BentoShortcutsClassicDB.MultiWhisperIgnore[playerKey] then
                        SendChatMessage(msgContent, "WHISPER", nil, playerInfo.fullName)
                        BentoShortcutsClassicDB.MultiWhisperIgnore[playerKey] = true
                        sentMsgCount = sentMsgCount + 1
                    end
                end
            end
        end
    end
end

SLASH_MULTIWHISPER_SKIP1 = "/spam"
SlashCmdList["MULTIWHISPER_SKIP"] = broadcastSkipSent

-- Reset spam tracking database for fresh message campaigns

local function resetSpamDb()
    if BentoShortcutsClassicDB and BentoShortcutsClassicDB.MultiWhisperIgnore then
        BentoShortcutsClassicDB.MultiWhisperIgnore = {}
        print("MultiWhisper ignore list cleared.")
    else
        print("MultiWhisper ignore list is already empty.")
    end
end

SLASH_CLEARPLAYERLIST1 = "/clearplayerlist"
SlashCmdList["CLEARPLAYERLIST"] = resetSpamDb