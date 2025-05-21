-- SYNCHRONIZE MUTED SOUND IDS WITH BENTOSHORTCUTSCLASSICDB

local defaultMutedSoundIds = {
    555124, -- MechaStriderLoop
    567719, -- GunLoad01
    567720, -- GunLoad02
    567723, -- GunLoad03
    567670, -- BowPreCastLoop
    567677, -- BowPullback
    567675, -- BowPullback02
    567676, -- BowPullback03
    569429, -- PetScreech
}

-- INITIALIZE SAVEDVARIABLES TABLES IF NEEDED

local function ensureSavedVariables()
    if type(BentoMutedSounds) ~= "table" then
        BentoMutedSounds = {}
    end
    if type(BentoShortcutsClassicDB) ~= "table" then
        BentoShortcutsClassicDB = {}
    end
    if type(BentoShortcutsClassicDB.MutedSounds) ~= "table" then
        BentoShortcutsClassicDB.MutedSounds = {}
    end
end

-- SYNC BENTOMUTEDSOUNDS WITH DB

local function syncMutedSoundsTables()
    ensureSavedVariables()
    wipe(BentoMutedSounds)
    for i, soundId in ipairs(BentoShortcutsClassicDB.MutedSounds) do
        BentoMutedSounds[i] = soundId
    end
end

-- APPLY ALL MUTED SOUNDS FROM DB

local function applySoundConfiguration()
    syncMutedSoundsTables()
    for _, soundId in ipairs(BentoShortcutsClassicDB.MutedSounds) do
        MuteSoundFile(soundId)
    end
end

-- ADD SOUND ID TO BOTH TABLES

local function addMutedSound(soundId)
    ensureSavedVariables()
    for _, id in ipairs(BentoShortcutsClassicDB.MutedSounds) do
        if id == soundId then return end
    end
    table.insert(BentoShortcutsClassicDB.MutedSounds, soundId)
    table.insert(BentoMutedSounds, soundId)
    MuteSoundFile(soundId)
end

-- CLEAR ALL MUTED SOUNDS FROM BOTH TABLES

local function clearMutedSounds()
    ensureSavedVariables()
    for _, soundId in ipairs(BentoShortcutsClassicDB.MutedSounds) do
        UnmuteSoundFile(soundId)
    end
    wipe(BentoShortcutsClassicDB.MutedSounds)
    wipe(BentoMutedSounds)
end

-- RESTORE DEFAULT SOUNDS TO BOTH TABLES

local function restoreDefaultSounds()
    clearMutedSounds()
    for _, soundId in ipairs(defaultMutedSoundIds) do
        addMutedSound(soundId)
    end
end

-- PRINT CURRENTLY MUTED SOUNDS FROM DB

local function printMutedSounds()
    ensureSavedVariables()
    if #BentoShortcutsClassicDB.MutedSounds == 0 then
        print("No sounds are currently muted.")
        return
    end
    print("Muted sound IDs:")
    for _, soundId in ipairs(BentoShortcutsClassicDB.MutedSounds) do
        print("- " .. tostring(soundId))
    end
end

-- SLASH COMMAND HANDLER

SLASH_MUTESOUND1 = "/mutesound"
SlashCmdList["MUTESOUND"] = function(msg)
    local arg = msg and msg:match("^%s*(.-)%s*$") or ""
    if arg == "" then
        print("Usage: /mutesound <ID|clear|check|default>")
        return
    end
    if arg == "clear" then
        clearMutedSounds()
        print("All muted sounds cleared.")
        return
    elseif arg == "check" then
        printMutedSounds()
        return
    elseif arg == "default" then
        restoreDefaultSounds()
        print("Default muted sounds restored.")
        return
    end
    local soundId = tonumber(arg)
    if soundId then
        addMutedSound(soundId)
        print("Muted sound ID: " .. soundId)
    else
        print("Invalid argument. Usage: /mutesound <ID|clear|check|default>")
    end
end

local configEvents = CreateFrame("Frame")
configEvents:RegisterEvent("PLAYER_ENTERING_WORLD")
configEvents:SetScript("OnEvent", applySoundConfiguration)