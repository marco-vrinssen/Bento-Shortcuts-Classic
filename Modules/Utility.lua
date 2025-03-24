-- READY CHECK

local function readyCheck()
    DoReadyCheck()
end

SLASH_READYCHECK1 = "/rc"
SlashCmdList["READYCHECK"] = readyCheck

-- QUIT GROUP

local function quitParty() 
    if IsInGroup() then 
        LeaveParty() 
    end 
end

SLASH_QUITPARTY1 = "/q"
SlashCmdList["QUITPARTY"] = quitParty

-- TOGGLE LUA ERRORS

local function toggleLUAErrors()
    local currentSetting = GetCVar("scriptErrors")
    if currentSetting == "1" then
        SetCVar("scriptErrors", 0)
        print(YELLOW_CHAT_LUA .. "LUA Errors: " .. "|r" .. WHITE_CHAT_LUA .. "Disabled" .. "|r")
    else
        SetCVar("scriptErrors", 1)
        print(YELLOW_CHAT_LUA .. "LUA Errors: " .. "|r" .. WHITE_CHAT_LUA .. "Enabled" .. "|r")
    end
end

SLASH_TOGGLELUA1 = "/errors"
SlashCmdList["TOGGLELUA"] = toggleLUAErrors

-- RELOAD THE UI

SLASH_RELOADUI1 = "/ui"
SlashCmdList["RELOADUI"] = function()
    ReloadUI()
end

-- RESTART THE GRAPHICS ENGINE

SLASH_GXRESTART1 = "/gx"
SlashCmdList["GXRESTART"] = function()
    ConsoleExec("gxRestart")
end

-- RELOAD THE UI AND RESTART THE GRAPHICS ENGINE AND CLEAR GAME CACHE

local function fullReload()
    ReloadUI()
    ConsoleExec("gxRestart")
    ConsoleExec("clearCache")
end

SLASH_FULLRELOAD1 = "/rl"
SlashCmdList["FULLRELOAD"] = fullReload

-- RELOAD UI ON GAME MICRO MENU RIGHT CLICK

MainMenuMicroButton:HookScript("OnClick", function(self, buttonClicked)
    if buttonClicked == "RightButton" then
        ReloadUI()
    end
end)