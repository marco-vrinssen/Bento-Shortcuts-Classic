-- ENABLE COMMAND INTRO MESSAGE

local function commandsIntro()
    print(YELLOW_CHAT_LUA .. "/bentoshortcuts" .. "|r" .. " for available commands.")
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

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Bento Commands" .. "|r")
    
    tooltip:AddLine(" ")
    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Keyword Scanning" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/scan KEYWORD" .. "|r" .. WHITE_CHAT_LUA .. ": Monitor chat channels for messages containing keyword." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/scan stop" .. "|r" .. WHITE_CHAT_LUA .. ": End scanning." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/scan clear" .. "|r" .. WHITE_CHAT_LUA .. ": End scanning." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Multi Messaging" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/w+ MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Whisper to all players in current /who list." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/w+ N MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Whisper first N players only." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/w+ -CLASS MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Exclude players of specified class." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/r+ MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Reply to recent whisper senders." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/r+ N MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Reply to last N whisper senders." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/lfg MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Broadcast to World and LookingForGroup channels." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/ws MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Whisper to all sellers of currently displayed auctions." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Player Targeting" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/find NAME" .. "|r" .. WHITE_CHAT_LUA .. ": Set find macro to specified name." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/find" .. "|r" .. WHITE_CHAT_LUA .. ": Set find macro to current target's name." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/find+ NAME" .. "|r" .. WHITE_CHAT_LUA .. ": Add specified name to find macro." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/find+" .. "|r" .. WHITE_CHAT_LUA .. ": Add current target to find macro." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Travel Shortcuts" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/travel ZONE" .. "|r" .. WHITE_CHAT_LUA .. ": Find warlocks offering summons to specified zone." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/travel" .. "|r" .. WHITE_CHAT_LUA .. ": Find mages offering portals in current zone." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Group Utility" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/rc" .. "|r" .. WHITE_CHAT_LUA .. ": Perform ready check." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/q" .. "|r" .. WHITE_CHAT_LUA .. ": Leave current party/raid." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "System Commands" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/errors" .. "|r" .. WHITE_CHAT_LUA .. ": Toggle LUA error display." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/ui" .. "|r" .. WHITE_CHAT_LUA .. ": Reload interface." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/gx" .. "|r" .. WHITE_CHAT_LUA .. ": Restart graphics engine." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/rl" .. "|r" .. WHITE_CHAT_LUA .. ": Reload UI, restart graphics, clear cache." .. "|r")

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