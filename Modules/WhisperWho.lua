-- Track whisper parameters for flexible messaging

local function getWhisperParams(commandString)
    local playerLimit, skipClass, messageText
    playerLimit, skipClass, messageText = commandString:match("^(%d+)%s*-%s*(%w+)%s+(.+)$")
    if not playerLimit then
        playerLimit, messageText = commandString:match("^(%d+)%s+(.+)$")
        if not playerLimit then
            skipClass, messageText = commandString:match("^%-(%w+)%s+(.+)$")
            if not skipClass then
                messageText = commandString
            end
        end
    end
    return playerLimit, skipClass, messageText
end

-- Send whisper to who results with optional filtering

local function sendWhoWhisper(commandString)
    local playerLimit, skipClass, messageText = getWhisperParams(commandString)
    local whoCount = C_FriendList.GetNumWhoResults()
    playerLimit = playerLimit and tonumber(playerLimit) or whoCount
    skipClass = skipClass and skipClass:lower() or nil
    if messageText and messageText ~= "" and whoCount and whoCount > 0 then
        local sentCount = 0
        for i = 1, whoCount do
            if sentCount >= playerLimit then break end
            local info = C_FriendList.GetWhoInfo(i)
            if info and info.fullName then
                if not skipClass or info.classStr:lower() ~= skipClass then
                    SendChatMessage(messageText, "WHISPER", nil, info.fullName)
                    sentCount = sentCount + 1
                end
            end
        end
    end
end

SLASH_WHISPERWHO1 = "/ww"
SlashCmdList["WHISPERWHO"] = sendWhoWhisper

-- Initialize ignore list for spam protection

local function initIgnoreList()
    if not BentoShortcutsClassicDB then
        BentoShortcutsClassicDB = {}
    end
    if type(BentoShortcutsClassicDB.MultiWhisperIgnore) ~= "table" then
        BentoShortcutsClassicDB.MultiWhisperIgnore = {}
    end
end

-- Send whisper to who results, skipping already sent players

local function sendWhoWhisperSkip(commandString)
    initIgnoreList()
    local playerLimit, skipClass, messageText = getWhisperParams(commandString)
    local whoCount = C_FriendList.GetNumWhoResults()
    playerLimit = playerLimit and tonumber(playerLimit) or whoCount
    skipClass = skipClass and skipClass:lower() or nil
    if messageText and messageText ~= "" and whoCount and whoCount > 0 then
        local sentCount = 0
        for i = 1, whoCount do
            if sentCount >= playerLimit then break end
            local info = C_FriendList.GetWhoInfo(i)
            if info and info.fullName then
                local playerKey = info.fullName
                if (not skipClass or info.classStr:lower() ~= skipClass) and not BentoShortcutsClassicDB.MultiWhisperIgnore[playerKey] then
                    SendChatMessage(messageText, "WHISPER", nil, info.fullName)
                    BentoShortcutsClassicDB.MultiWhisperIgnore[playerKey] = true
                    sentCount = sentCount + 1
                end
            end
        end
    end
end

SLASH_WHISPERWHO_SKIP1 = "/ww+"
SlashCmdList["WHISPERWHO_SKIP"] = sendWhoWhisperSkip

-- Reset ignore list for new message campaigns

local function resetIgnoreList()
    if BentoShortcutsClassicDB and BentoShortcutsClassicDB.MultiWhisperIgnore then
        BentoShortcutsClassicDB.MultiWhisperIgnore = {}
        print(YELLOW_LIGHT_LUA .. "[Whisper Shortcut]: " .. WHITE_LUA .. "MultiWhisper ignore list cleared.")
    else
        print(YELLOW_LIGHT_LUA .. "[Whisper Shortcut]: " .. WHITE_LUA .. "MultiWhisper ignore list is already empty.")
    end
end

SLASH_CLEARSKIPLIST1 = "/clearskiplist"
SlashCmdList["CLEARSKIPLIST"] = resetIgnoreList