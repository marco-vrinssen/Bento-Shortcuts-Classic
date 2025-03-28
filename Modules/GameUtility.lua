-- TOGGLE LUA ERRORS

SLASH_TOGGLELUA1 = "/errors"
SlashCmdList["TOGGLELUA"] = function()
    local showErrors = GetCVar("scriptErrors")
    if showErrors == "1" then
        SetCVar("scriptErrors", 0)
        print(YELLOW_CHAT_LUA .. "LUA Errors: " .. "|r" .. "Off")
    else
        SetCVar("scriptErrors", 1)
        print(YELLOW_CHAT_LUA .. "LUA Errors: " .. "|r" .. "On")
    end
end

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

-- CUSTOM TOOLTIP FOR MAIN MENU MICRO BUTTON

local altTooltip = CreateFrame("GameTooltip", "CustomTooltip", UIParent, "GameTooltipTemplate")

MainMenuMicroButton:HookScript("OnEnter", function(self)
    altTooltip:SetOwner(GameTooltip, "ANCHOR_NONE")
    altTooltip:SetPoint("TOPLEFT", GameTooltip, "BOTTOMLEFT", 0, -2)
    altTooltip:SetPoint("TOPRIGHT", GameTooltip, "BOTTOMRIGHT", 0, -2)
    altTooltip:ClearLines()
    altTooltip:AddLine("Right-Click: Reload UI", 1, 1, 1)
    altTooltip:Show()
end)

MainMenuMicroButton:HookScript("OnLeave", function()
    altTooltip:Hide()
end)