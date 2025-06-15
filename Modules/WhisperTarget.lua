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
        print(YELLOW_LIGHT_LUA .. "[Whisper Shortcut]: " .. WHITE_LUA .. "Usage: /wt MESSAGE")
        return
    end
    if UnitExists("target") and UnitIsPlayer("target") then
        local targetName = UnitName("target")
        SendChatMessage(messageText, "WHISPER", nil, targetName)
    else
        print(YELLOW_LIGHT_LUA .. "[Whisper Shortcut]: " .. WHITE_LUA .. "No valid player target selected")
    end
end

-- Send whisper to target with ignore tracking

local function sendTargetWhisperProtected(messageText)
    if not messageText or messageText == "" then
        print(YELLOW_LIGHT_LUA .. "[Whisper Shortcut]: " .. WHITE_LUA .. "Usage: /wt+ MESSAGE")
        return
    end
    if UnitExists("target") and UnitIsPlayer("target") then
        local targetName = UnitName("target")
        initTargetIgnoreList()
        if not BentoShortcutsClassicDB.MultiWhisperIgnore[targetName] then
            SendChatMessage(messageText, "WHISPER", nil, targetName)
            BentoShortcutsClassicDB.MultiWhisperIgnore[targetName] = true
        else
            print(YELLOW_LIGHT_LUA .. "[Whisper Shortcut]: " .. WHITE_LUA .. "Player " .. targetName .. " already contacted")
        end
    else
        print(YELLOW_LIGHT_LUA .. "[Whisper Shortcut]: " .. WHITE_LUA .. "No valid player target selected")
    end
end

-- Register slash commands for target whisper

SLASH_WHISPERTARGET1 = "/wt"
SlashCmdList["WHISPERTARGET"] = sendTargetWhisper

SLASH_WHISPERTARGET_SKIP1 = "/wt+"
SlashCmdList["WHISPERTARGET_SKIP"] = sendTargetWhisperProtected
