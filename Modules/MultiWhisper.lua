-- Extract whisper parameters from command string to enable flexible messaging

local function extractWhisperParams(commandString)
    local playerLimit, excludedClass, messageContent
    
    playerLimit, excludedClass, messageContent = commandString:match("^(%d+)%s*-%s*(%w+)%s+(.+)$")
    if not playerLimit then
        playerLimit, messageContent = commandString:match("^(%d+)%s+(.+)$")
        if not playerLimit then
            excludedClass, messageContent = commandString:match("^%-(%w+)%s+(.+)$")
            if not excludedClass then
                messageContent = commandString
            end
        end
    end
    
    return playerLimit, excludedClass, messageContent
end

-- Broadcast messages to who results with optional filtering

local function broadcastToWho(commandString)
    local playerLimit, excludedClass, messageContent = extractWhisperParams(commandString)
    
    local whoResultCount = C_FriendList.GetNumWhoResults()
    if playerLimit then
        playerLimit = tonumber(playerLimit)
    else
        playerLimit = whoResultCount
    end
    if excludedClass then
        excludedClass = excludedClass:lower()
    end

    if messageContent and messageContent ~= "" and whoResultCount and whoResultCount > 0 then
        local sentMessageCount = 0
        for i = 1, whoResultCount do
            if sentMessageCount >= playerLimit then break end
            local playerInfo = C_FriendList.GetWhoInfo(i)
            if playerInfo and playerInfo.fullName then
                if excludedClass then
                    if playerInfo.classStr:lower() ~= excludedClass then
                        SendChatMessage(messageContent, "WHISPER", nil, playerInfo.fullName)
                        sentMessageCount = sentMessageCount + 1
                    end
                else
                    SendChatMessage(messageContent, "WHISPER", nil, playerInfo.fullName)
                    sentMessageCount = sentMessageCount + 1
                end
            end
        end
    end
end

SLASH_MULTIWHISPER1 = "/w+"
SlashCmdList["MULTIWHISPER"] = broadcastToWho

-- Initialize spam database to prevent duplicate messages

local function initSpamDatabase()
    if not BentoShortcutsClassicDB then
        BentoShortcutsClassicDB = {}
    end
    if type(BentoShortcutsClassicDB.MultiWhisperIgnore) ~= "table" then
        BentoShortcutsClassicDB.MultiWhisperIgnore = {}
    end
end

-- Broadcast messages while tracking sent players to prevent spam

local function broadcastSkipSent(commandString)
    initSpamDatabase()

    local playerLimit, excludedClass, messageContent = extractWhisperParams(commandString)
    
    local whoResultCount = C_FriendList.GetNumWhoResults()
    if playerLimit then
        playerLimit = tonumber(playerLimit)
    else
        playerLimit = whoResultCount
    end
    if excludedClass then
        excludedClass = excludedClass:lower()
    end

    if messageContent and messageContent ~= "" and whoResultCount and whoResultCount > 0 then
        local sentMessageCount = 0
        for i = 1, whoResultCount do
            if sentMessageCount >= playerLimit then break end
            local playerInfo = C_FriendList.GetWhoInfo(i)
            if playerInfo and playerInfo.fullName then
                local playerKey = playerInfo.fullName
                if excludedClass then
                    if playerInfo.classStr:lower() ~= excludedClass then
                        if not BentoShortcutsClassicDB.MultiWhisperIgnore[playerKey] then
                            SendChatMessage(messageContent, "WHISPER", nil, playerInfo.fullName)
                            BentoShortcutsClassicDB.MultiWhisperIgnore[playerKey] = true
                            sentMessageCount = sentMessageCount + 1
                        end
                    end
                else
                    if not BentoShortcutsClassicDB.MultiWhisperIgnore[playerKey] then
                        SendChatMessage(messageContent, "WHISPER", nil, playerInfo.fullName)
                        BentoShortcutsClassicDB.MultiWhisperIgnore[playerKey] = true
                        sentMessageCount = sentMessageCount + 1
                    end
                end
            end
        end
    end
end

SLASH_MULTIWHISPER_SKIP1 = "/spam"
SlashCmdList["MULTIWHISPER_SKIP"] = broadcastSkipSent

-- Reset spam tracking database for fresh message campaigns

local function resetSpamDatabase()
    if BentoShortcutsClassicDB and BentoShortcutsClassicDB.MultiWhisperIgnore then
        BentoShortcutsClassicDB.MultiWhisperIgnore = {}
        print("MultiWhisper ignore list cleared.")
    else
        print("MultiWhisper ignore list is already empty.")
    end
end

SLASH_CLEARPLAYERLIST1 = "/clearplayerlist"
SlashCmdList["CLEARPLAYERLIST"] = resetSpamDatabase