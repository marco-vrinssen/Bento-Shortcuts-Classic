-- WHISPER PLAYERS IN /WHO LIST WITHOUT SKIP LIST CHECK

local function whisperPlayers(msg)
    local messageLimit, classExclusion, whisperMessage
    messageLimit, classExclusion, whisperMessage = msg:match("^(%d+)%s*-%s*(%w+)%s+(.+)$")
    if not messageLimit then
        messageLimit, whisperMessage = msg:match("^(%d+)%s+(.+)$")
        if not messageLimit then
            classExclusion, whisperMessage = msg:match("^%-(%w+)%s+(.+)$")
            if not classExclusion then
                whisperMessage = msg
            end
        end
    end
    local totalWhoResults = C_FriendList.GetNumWhoResults()
    if messageLimit then
        messageLimit = tonumber(messageLimit)
    else
        messageLimit = totalWhoResults
    end
    if classExclusion then
        classExclusion = classExclusion:lower()
    end
    if whisperMessage and whisperMessage ~= "" and totalWhoResults and totalWhoResults > 0 then
        local currentWhisperCount = 0
        for i = 1, totalWhoResults do
            if currentWhisperCount >= messageLimit then break end
            local playerWhoInfo = C_FriendList.GetWhoInfo(i)
            if playerWhoInfo and playerWhoInfo.fullName then
                if classExclusion then
                    if playerWhoInfo.classStr:lower() ~= classExclusion then
                        SendChatMessage(whisperMessage, "WHISPER", nil, playerWhoInfo.fullName)
                        currentWhisperCount = currentWhisperCount + 1
                    end
                else
                    SendChatMessage(whisperMessage, "WHISPER", nil, playerWhoInfo.fullName)
                    currentWhisperCount = currentWhisperCount + 1
                end
            end
        end
    end
end

SLASH_MULTIWHISPER1 = "/w+"
SlashCmdList["MULTIWHISPER"] = whisperPlayers

-- WHISPER PLAYERS WITH SKIP LIST FUNCTIONALITY

local function whisperPlayersWithSkip(msg)
    if not BentoShortcutsClassicDB then
        BentoShortcutsClassicDB = {}
    end
    if type(BentoShortcutsClassicDB.MultiWhisperIgnore) ~= "table" then
        BentoShortcutsClassicDB.MultiWhisperIgnore = {}
    end
    local messageLimit, classExclusion, whisperMessage
    messageLimit, classExclusion, whisperMessage = msg:match("^(%d+)%s*-%s*(%w+)%s+(.+)$")
    if not messageLimit then
        messageLimit, whisperMessage = msg:match("^(%d+)%s+(.+)$")
        if not messageLimit then
            classExclusion, whisperMessage = msg:match("^%-(%w+)%s+(.+)$")
            if not classExclusion then
                whisperMessage = msg
            end
        end
    end
    local totalWhoResults = C_FriendList.GetNumWhoResults()
    if messageLimit then
        messageLimit = tonumber(messageLimit)
    else
        messageLimit = totalWhoResults
    end
    if classExclusion then
        classExclusion = classExclusion:lower()
    end
    if whisperMessage and whisperMessage ~= "" and totalWhoResults and totalWhoResults > 0 then
        local currentWhisperCount = 0
        for i = 1, totalWhoResults do
            if currentWhisperCount >= messageLimit then break end
            local playerWhoInfo = C_FriendList.GetWhoInfo(i)
            if playerWhoInfo and playerWhoInfo.fullName then
                local ignoredPlayerKey = playerWhoInfo.fullName
                if classExclusion then
                    if playerWhoInfo.classStr:lower() ~= classExclusion then
                        if not BentoShortcutsClassicDB.MultiWhisperIgnore[ignoredPlayerKey] then
                            SendChatMessage(whisperMessage, "WHISPER", nil, playerWhoInfo.fullName)
                            BentoShortcutsClassicDB.MultiWhisperIgnore[ignoredPlayerKey] = true
                            currentWhisperCount = currentWhisperCount + 1
                        end
                    end
                else
                    if not BentoShortcutsClassicDB.MultiWhisperIgnore[ignoredPlayerKey] then
                        SendChatMessage(whisperMessage, "WHISPER", nil, playerWhoInfo.fullName)
                        BentoShortcutsClassicDB.MultiWhisperIgnore[ignoredPlayerKey] = true
                        currentWhisperCount = currentWhisperCount + 1
                    end
                end
            end
        end
    end
end

SLASH_MULTIWHISPER_SKIP1 = "/w+-"
SlashCmdList["MULTIWHISPER_SKIP"] = whisperPlayersWithSkip

-- CLEAR MULTIWHISPER SKIP LIST FUNCTIONALITY

local function clearMultiWhisperIgnore()
    if BentoShortcutsClassicDB and BentoShortcutsClassicDB.MultiWhisperIgnore then
        BentoShortcutsClassicDB.MultiWhisperIgnore = {}
        print("MultiWhisper ignore list cleared.")
    else
        print("MultiWhisper ignore list is already empty.")
    end
end

SLASH_CLEARPLAYERLIST1 = "/clearplayerlist"
SlashCmdList["CLEARPLAYERLIST"] = clearMultiWhisperIgnore