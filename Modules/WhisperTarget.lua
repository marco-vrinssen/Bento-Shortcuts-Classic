-- Initialize ignore list for target whisper spam protection

local function initTargetIgnoreList()
    if not BentoShortcutsClassicDB then
        BentoShortcutsClassicDB = {}
    end
    if type(BentoShortcutsClassicDB.MultiWhisperIgnore) ~= "table" then
        BentoShortcutsClassicDB.MultiWhisperIgnore = {}
    end
end

-- Send whisper to current target

local function sendTargetWhisper(messageText)
    if not messageText or messageText == "" then
        print("Usage: /wt MESSAGE")
        return
    end
    if UnitExists("target") and UnitIsPlayer("target") then
        local targetName = UnitName("target")
        SendChatMessage(messageText, "WHISPER", nil, targetName)
    else
        print("You need a valid player target to whisper.")
    end
end

-- Send whisper to target with ignore tracking

local function sendTargetWhisperProtected(messageText)
    if not messageText or messageText == "" then
        print("Usage: /wt- MESSAGE")
        return
    end
    if UnitExists("target") and UnitIsPlayer("target") then
        local targetName = UnitName("target")
        initTargetIgnoreList()
        if not BentoShortcutsClassicDB.MultiWhisperIgnore[targetName] then
            SendChatMessage(messageText, "WHISPER", nil, targetName)
            BentoShortcutsClassicDB.MultiWhisperIgnore[targetName] = true
        else
            print(YELLOW_LIGHT_LUA .. "[Target Whisper]:|r Player skipped.")
        end
    else
        print("You need a valid player target to whisper.")
    end
end

-- Register slash commands for target whisper

SLASH_TARGETWHISPER1 = "/wt"
SlashCmdList["TARGETWHISPER"] = sendTargetWhisper

SLASH_TARGETWHISPERPROTECTED1 = "/wt-"
SlashCmdList["TARGETWHISPERPROTECTED"] = sendTargetWhisperProtected
