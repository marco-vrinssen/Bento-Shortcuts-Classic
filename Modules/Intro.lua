-- ENABLE COMMAND INTRO MESSAGE

local function commandsIntro()
    print(YELLOW_LIGHT_LUA .. "/bentoshortcuts" .. "|r" .. " for available commands.")
end

local introEvents = CreateFrame("Frame")
introEvents:RegisterEvent("PLAYER_LOGIN")
introEvents:SetScript("OnEvent", commandsIntro)

-- SHOW COMMAND LIST IN TOOLTIP

local function showCommandList()
    local tooltip = _G["CommandListTooltip"] or CreateFrame("GameTooltip", "CommandListTooltip", UIParent, "GameTooltipTemplate")
    tooltip:ClearLines()
    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:SetPoint("CENTER", UIParent, "CENTER")
    tooltip:SetMovable(true)
    tooltip:EnableMouse(true)
    tooltip:RegisterForDrag("LeftButton")
    tooltip:SetScript("OnDragStart", tooltip.StartMoving)
    tooltip:SetScript("OnDragStop", tooltip.StopMovingOrSizing)
    tooltip:SetResizable(true)

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Bento Commands" .. "|r")
    
    tooltip:AddLine(" ")
    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Keyword Scanning" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/scan KEYWORD" .. "|r" .. WHITE_LUA .. ": Monitor chat channels for messages containing keyword." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/scan stop" .. "|r" .. WHITE_LUA .. ": End scanning." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/scan clear" .. "|r" .. WHITE_LUA .. ": End scanning." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Multi Messaging" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/w+ MESSAGE" .. "|r" .. WHITE_LUA .. ": Whisper to all players in current /who list." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/w+ N MESSAGE" .. "|r" .. WHITE_LUA .. ": Whisper first N players only." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/w+ -CLASS MESSAGE" .. "|r" .. WHITE_LUA .. ": Exclude players of specified class." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/r+ MESSAGE" .. "|r" .. WHITE_LUA .. ": Reply to recent whisper senders." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/r+ N MESSAGE" .. "|r" .. WHITE_LUA .. ": Reply to last N whisper senders." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/lfg MESSAGE" .. "|r" .. WHITE_LUA .. ": Broadcast to World and LookingForGroup channels." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/ws MESSAGE" .. "|r" .. WHITE_LUA .. ": Whisper to all sellers of currently displayed auctions." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Gear Manager" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/gearset NAME" .. "|r" .. WHITE_LUA .. ": Save your currently equipped gear as a set named NAME." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/equipset NAME" .. "|r" .. WHITE_LUA .. ": Equip the gear set named NAME." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Player Targeting" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/find NAME" .. "|r" .. WHITE_LUA .. ": Set find macro to specified name." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/find" .. "|r" .. WHITE_LUA .. ": Set find macro to current target's name." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/find+ NAME" .. "|r" .. WHITE_LUA .. ": Add specified name to find macro." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/find+" .. "|r" .. WHITE_LUA .. ": Add current target to find macro." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Travel Shortcuts" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/travel ZONE" .. "|r" .. WHITE_LUA .. ": Find warlocks offering summons to specified zone." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/travel" .. "|r" .. WHITE_LUA .. ": Find mages offering portals in current zone." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Group Utility" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/rc" .. "|r" .. WHITE_LUA .. ": Perform ready check." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/q" .. "|r" .. WHITE_LUA .. ": Leave current party/raid." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "System Commands" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/errors" .. "|r" .. WHITE_LUA .. ": Toggle LUA error display." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/ui" .. "|r" .. WHITE_LUA .. ": Reload interface." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/gx" .. "|r" .. WHITE_LUA .. ": Restart graphics engine." .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/rl" .. "|r" .. WHITE_LUA .. ": Reload UI, restart graphics, clear cache." .. "|r")

    tooltip:Show()

    local closeButton = CreateFrame("Button", nil, tooltip, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", tooltip, "TOPRIGHT")
    closeButton:SetScript("OnClick", function()
        tooltip:Hide()
    end)
end

SLASH_BENTOSHORTCUTS1 = "/bentoshortcuts"
SlashCmdList["BENTOSHORTCUTS"] = function(msg, editBox)
    if msg == "" then
        showCommandList()
    end
end