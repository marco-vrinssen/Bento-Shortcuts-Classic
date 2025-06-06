-- Add slash command to toggle lua error display

SLASH_ERRORDISPLAY1 = "/errors"
SlashCmdList["ERRORDISPLAY"] = function()
    local errorState = GetCVar("scriptErrors")
    if errorState == "1" then
        SetCVar("scriptErrors", 0)
        print(YELLOW_LIGHT_LUA .. "[Error Display]:|r Off")
    else
        SetCVar("scriptErrors", 1)
        print(YELLOW_LIGHT_LUA .. "[Error Display]:|r On")
    end
end

-- Add slash command to reload ui

SLASH_RELOADUI1 = "/ui"
SlashCmdList["RELOADUI"] = function()
    ReloadUI()
end

-- Add slash command to restart graphics engine

SLASH_GXRESTART1 = "/gx"
SlashCmdList["GXRESTART"] = function()
    ConsoleExec("gxRestart")
end

-- Create full system reload function

local function performFullReload()
    ReloadUI()
    ConsoleExec("gxRestart")
    ConsoleExec("clearCache")
end

SLASH_FULLRELOAD1 = "/rl"
SlashCmdList["FULLRELOAD"] = performFullReload

-- Hook main menu button to reload ui on right click

MainMenuMicroButton:HookScript("OnClick", function(self, buttonPressed)
    if buttonPressed == "RightButton" then
        ReloadUI()
    end
end)

-- Create custom tooltip for main menu button

local customTooltip = CreateFrame("GameTooltip", "CustomTooltip", UIParent, "GameTooltipTemplate")

MainMenuMicroButton:HookScript("OnEnter", function(self)
    customTooltip:SetOwner(GameTooltip, "ANCHOR_NONE")
    customTooltip:SetPoint("TOPLEFT", GameTooltip, "BOTTOMLEFT", 0, -2)
    customTooltip:SetPoint("TOPRIGHT", GameTooltip, "BOTTOMRIGHT", 0, -2)
    customTooltip:ClearLines()
    customTooltip:AddLine("Right-Click: Reload UI", 1, 1, 1)
    customTooltip:Show()
end)

MainMenuMicroButton:HookScript("OnLeave", function()
    customTooltip:Hide()
end)