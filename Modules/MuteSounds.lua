-- Initialize defaultSoundIdList with sound ID comments for clarity

local defaultSoundIdList = {
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

-- Create defaultSoundIdLookup for efficient lookup

local defaultSoundIdLookup = {}
for _, soundId in ipairs(defaultSoundIdList) do
    defaultSoundIdLookup[soundId] = true
end

-- Initialize persistent storage tables for sound management

local function initializeSoundStorage()
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

-- Synchronize BentoMutedSounds cache with persistent database

local function syncMutedSoundCache()
    initializeSoundStorage()
    wipe(BentoMutedSounds)
    for index, soundId in ipairs(BentoShortcutsClassicDB.MutedSounds) do
        BentoMutedSounds[index] = soundId
    end
end

-- Apply muted sound configuration from database

local function applyMutedSoundConfig()
    syncMutedSoundCache()
    for _, soundId in ipairs(BentoShortcutsClassicDB.MutedSounds) do
        MuteSoundFile(soundId)
    end
end

-- Validate soundId is a positive number

local function isSoundIdValid(soundId)
    return type(soundId) == "number" and soundId > 0
end

-- Check if soundId is already muted

local function isSoundIdMuted(soundId)
    for _, mutedId in ipairs(BentoShortcutsClassicDB.MutedSounds) do
        if mutedId == soundId then
            return true
        end
    end
    return false
end

-- Register soundId for muting in storage

local function addMutedSoundId(soundId)
    if not isSoundIdValid(soundId) then
        return false
    end

    initializeSoundStorage()
    if isSoundIdMuted(soundId) then
        return false
    end

    table.insert(BentoShortcutsClassicDB.MutedSounds, soundId)
    table.insert(BentoMutedSounds, soundId)
    MuteSoundFile(soundId)
    return true
end

-- Remove all muted sound IDs from storage

local function clearMutedSoundIds()
    initializeSoundStorage()
    for _, soundId in ipairs(BentoShortcutsClassicDB.MutedSounds) do
        UnmuteSoundFile(soundId)
    end
    wipe(BentoShortcutsClassicDB.MutedSounds)
    wipe(BentoMutedSounds)
end

-- Reset muted sound IDs to default list

local function resetMutedSoundDefaults()
    clearMutedSoundIds()
    for _, soundId in ipairs(defaultSoundIdList) do
        addMutedSoundId(soundId)
    end
end

-- Display current muted sound IDs

local function printMutedSoundIds()
    initializeSoundStorage()
    local mutedCount = #BentoShortcutsClassicDB.MutedSounds

    if mutedCount == 0 then
        print(YELLOW_LIGHT_LUA .. "[Sound Mute]:|r No sounds are currently muted.")
        return
    end

    print(YELLOW_LIGHT_LUA .. "[Sound Mute]:|r Muted sound IDs (" .. mutedCount .. "):")
    for _, soundId in ipairs(BentoShortcutsClassicDB.MutedSounds) do
        local isDefault = defaultSoundIdLookup[soundId] and " (default)" or ""
        print("- " .. tostring(soundId) .. isDefault)
    end
end

-- Process /mutesound slash command

local function handleMuteSoundSlashCmd(cmdArgs)
    local trimmedArgs = cmdArgs and cmdArgs:match("^%s*(.-)%s*$") or ""
    local helpMsg = YELLOW_LIGHT_LUA .. "[Sound Mute]:|r Usage: /mutesound [ID|clear|check|default]"

    if trimmedArgs == "" then
        print(helpMsg)
        return
    end

    if trimmedArgs == "clear" then
        clearMutedSoundIds()
        print(YELLOW_LIGHT_LUA .. "[Sound Mute]:|r All muted sounds cleared.")

    elseif trimmedArgs == "check" then
        printMutedSoundIds()

    elseif trimmedArgs == "default" then
        resetMutedSoundDefaults()
        print(YELLOW_LIGHT_LUA .. "[Sound Mute]:|r Default muted sounds restored.")

    else
        local soundId = tonumber(trimmedArgs)
        if soundId and addMutedSoundId(soundId) then
            print(YELLOW_LIGHT_LUA .. "[Sound Mute]:|r Muted sound ID: " .. soundId)
        else
            print(YELLOW_LIGHT_LUA .. "[Sound Mute]:|r Invalid sound ID or already muted.")
            print(helpMsg)
        end
    end
end

-- Register /mutesound slash command

SLASH_MUTESOUND1 = "/mutesound"
SlashCmdList["MUTESOUND"] = handleMuteSoundSlashCmd

-- Apply muted sound configuration on player login

local muteSoundEventFrame = CreateFrame("Frame")
muteSoundEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
muteSoundEventFrame:SetScript("OnEvent", applyMutedSoundConfig)