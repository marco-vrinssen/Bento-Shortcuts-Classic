-- INITIALIZE ADDON STATE AND TRACKING VARIABLES FOR HERB/MINERAL SWITCHER

local addonName = "TrackThemAll"
local trackingTimer = nil
local isRunning = false
local isPaused = false
local trackingSoundId = 567407 -- Button click sound for tracking toggle

-- DEFINE HERB AND MINERAL TRACKING SPELL CONFIGURATIONS WITH TEXTURES

local trackingSpells = {
    herbs = {
        name = "Find Herbs",
        texture = 133939
    },
    minerals = {
        name = "Find Minerals", 
        texture = 136025
    }
}

-- HANDLE ADDON LOADED EVENT AND REGISTER INITIAL SETUP MESSAGE

local function OnAddonLoaded(self, event, loadedAddonName)
    if loadedAddonName == addonName then
        print("TrackThemAll loaded! Use /tta to toggle herb/mineral tracking.")
        self:UnregisterEvent("ADDON_LOADED")
    end
end

-- IMPLEMENT SMART TRACKING TOGGLE BETWEEN HERBS AND MINERALS

local function ToggleTracking()
    if UnitAffectingCombat("player") then
        return
    end
    
    local currentTrackingTexture = GetTrackingTexture()
    
    if currentTrackingTexture == trackingSpells.herbs.texture then
        CastSpellByName(trackingSpells.minerals.name)
    else
        CastSpellByName(trackingSpells.herbs.name)
    end
end

-- MANAGE AUTOMATIC TRACKING TIMER WITH 3-SECOND INTERVALS

local function StartTimer()
    if trackingTimer then
        return
    end
    
    MuteSoundFile(trackingSoundId)
    print(YELLOW_LIGHT_LUA .. "[Tracking Switcher]:|r " .. "Started Herb and Mineral Tracking.")
    isRunning = true
    isPaused = false
    
    trackingTimer = C_Timer.NewTicker(1.5, function()
        if UnitAffectingCombat("player") then
            if not isPaused then
                print(YELLOW_LIGHT_LUA .. "[Tracking Switcher]:|r " .. "Tracking paused.")
                isPaused = true
            end
        else
            if isPaused then
                isPaused = false
            end
            ToggleTracking()
        end
    end)
end

local function StopTimer()
    if trackingTimer then
        trackingTimer:Cancel()
        trackingTimer = nil
    end
    
    UnmuteSoundFile(trackingSoundId)
    isRunning = false
    isPaused = false
    print(YELLOW_LIGHT_LUA .. "[Tracking Switcher]:|r " .. "Stopped Herb and Mineral Tracking.")
end

-- PROCESS SLASH COMMAND TO START OR STOP TRACKING AUTOMATION

local function SlashCommandHandler(msg)
    if isRunning then
        StopTimer()
    else
        StartTimer()
    end
end

-- REGISTER EVENT FRAME AND SLASH COMMAND FOR ADDON FUNCTIONALITY

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", OnAddonLoaded)

SLASH_TRACKTHEMALL1 = "/tta"
SlashCmdList["TRACKTHEMALL"] = SlashCommandHandler