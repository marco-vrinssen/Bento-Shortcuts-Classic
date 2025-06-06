-- Initialize addon state with tracking variables

local switchTimer = nil
local isActive = false
local isPaused = false

-- Define spell configurations with textures

local spellConfig = {
    herbs = { name = "Find Herbs", texture = 133939 },
    minerals = { name = "Find Minerals", texture = 136025 }
}

-- Toggle between herb and mineral tracking

local function ToggleTracking()
    if UnitAffectingCombat("player") then return end
    
    local currentTexture = GetTrackingTexture()
    local nextSpell = currentTexture == spellConfig.herbs.texture 
        and spellConfig.minerals.name 
        or spellConfig.herbs.name
    
    CastSpellByName(nextSpell)
end

-- Start automatic tracking timer

local function StartTimer()
    if switchTimer then return end
    
    print(YELLOW_LIGHT_LUA .. "[Tracking Switcher]:|r Started Herb and Mineral Tracking.")
    isActive = true
    isPaused = false
    
    switchTimer = C_Timer.NewTicker(1.5, function()
        if UnitAffectingCombat("player") then
            if not isPaused then
                print(YELLOW_LIGHT_LUA .. "[Tracking Switcher]:|r Tracking paused.")
                isPaused = true
            end
        else
            if isPaused then isPaused = false end
            ToggleTracking()
        end
    end)
end

-- Stop automatic tracking timer

local function StopTimer()
    if switchTimer then
        switchTimer:Cancel()
        switchTimer = nil
    end
    
    isActive = false
    isPaused = false
    print(YELLOW_LIGHT_LUA .. "[Tracking Switcher]:|r Stopped Herb and Mineral Tracking.")
end

-- Handle slash command toggle

local function SlashHandler()
    if isActive then StopTimer() else StartTimer() end
end

SLASH_TRACKINGSWITCHER1 = "/ts"
SlashCmdList["TRACKINGSWITCHER"] = SlashHandler