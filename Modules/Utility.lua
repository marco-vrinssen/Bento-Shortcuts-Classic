-- TOGGLE LUA ERRORS

SLASH_TOGGLELUA1 = "/errors"
SlashCmdList["TOGGLELUA"] = function()
    local showErrors = GetCVar("scriptErrors")
    if showErrors == "1" then
        SetCVar("scriptErrors", 0)
        print(YELLOW_LIGHT_LUA .. "LUA Errors: " .. "|r" .. "Off")
    else
        SetCVar("scriptErrors", 1)
        print(YELLOW_LIGHT_LUA .. "LUA Errors: " .. "|r" .. "On")
    end
end


-- RELOAD UI

SLASH_RELOADUI1 = "/ui"
SlashCmdList["RELOADUI"] = function()
    ReloadUI()
end


-- RESTART GRAPHICS ENGINE

SLASH_GXRESTART1 = "/gx"
SlashCmdList["GXRESTART"] = function()
    ConsoleExec("gxRestart")
end


-- FULL RELOAD: UI, GRAPHICS ENGINE, AND GAME CACHE

local function fullReload()
    ReloadUI()
    ConsoleExec("gxRestart")
    ConsoleExec("clearCache")
end

SLASH_FULLRELOAD1 = "/rl"
SlashCmdList["FULLRELOAD"] = fullReload


-- RELOAD UI ON MAIN MENU MICRO BUTTON RIGHT CLICK

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