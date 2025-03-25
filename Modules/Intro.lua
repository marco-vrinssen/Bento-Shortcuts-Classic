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

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Chat Filtering" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/f KEYWORD" .. "|r" .. WHITE_CHAT_LUA .. ": Filter all active channels for KEYWORD and repost matching messages." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/f KEYWORD1+KEYWORD2" .. "|r" .. WHITE_CHAT_LUA .. ": Filter all active channels for the combination of KEYWORD1 and KEYWORD2 and repost matching messages." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/f" .. "|r" .. WHITE_CHAT_LUA .. ": Clear and stop the filtering." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Multi Whisper" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/ww MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Send MESSAGE to all players in a currently open /who instance." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/ww N MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Send MESSAGE to the first N players in a currently open /who instance." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/ww -CLASS MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Send MESSAGE to all players except those of CLASS in a currently open /who instance." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/ww N -CLASS MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Send MESSAGE to the first N players except those of CLASS in a currently open /who instance." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Whisper Invite" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/wi" .. "|r" .. WHITE_CHAT_LUA .. ": Send MESSAGE and invite all players in the currently open /who list." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/wgi" .. "|r" .. WHITE_CHAT_LUA .. ": Send MESSAGE and guild invite all players in the currently open /who list." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Whisper Last" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/wl MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Send MESSAGE to all players who whispered you." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/wl N MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Send MESSAGE to the last N players who whispered you." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Whisper Sellers" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/wah MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Send MESSAGE to all unique sellers in current auction house search results." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/wah N MESSAGE" .. "|r" .. WHITE_CHAT_LUA .. ": Send MESSAGE to the first N unique sellers in current auction house search results." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Find Mages and Warlocks" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/port ZONE" .. "|r" .. WHITE_CHAT_LUA .. ": Search for warlocks in ZONE who can summon." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/port" .. "|r" .. WHITE_CHAT_LUA .. ": Search for mages in the current zone who can provide portals." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Close Whisper Tabs" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/c" .. "|r" .. WHITE_CHAT_LUA .. ": Close all whisper tabs." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Target Macros" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/fm TARGET" .. "|r" .. WHITE_CHAT_LUA .. ": Create or update a macro to target TARGET. If no TARGET is specified, the current target is used." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/fm NAME" .. "|r" .. WHITE_CHAT_LUA .. ": Create or update a macro to target NAME. If no NAME is specified, the current target is used." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/fm+ TARGET" .. "|r" .. WHITE_CHAT_LUA .. ": Add the current target or specified TARGET to the existing target macro. Up to 3 targets can be added." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/fm+ NAME" .. "|r" .. WHITE_CHAT_LUA .. ": Add the current target or specified NAME to the existing target macro. Up to 3 targets can be added." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/am TARGET" .. "|r" .. WHITE_CHAT_LUA .. ": Create or update a macro to assist TARGET. If no TARGET is specified, the current target is used." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/am NAME" .. "|r" .. WHITE_CHAT_LUA .. ": Create or update a macro to assist NAME. If no NAME is specified, the current target is used." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Group Utility" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/rc" .. "|r" .. WHITE_CHAT_LUA .. ": Perform a ready check." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/q" .. "|r" .. WHITE_CHAT_LUA .. ": Leave the current party or raid." .. "|r")

    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_CHAT_LUA .. "Game Utility" .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/ui" .. "|r" .. WHITE_CHAT_LUA .. ": Reload the user interface." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/gx" .. "|r" .. WHITE_CHAT_LUA .. ": Restart the graphics engine." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/le" .. "|r" .. WHITE_CHAT_LUA .. ": Toggle the display of LUA errors." .. "|r")
    tooltip:AddLine(YELLOW_CHAT_LUA .. "/rl" .. "|r" .. WHITE_CHAT_LUA .. ": Reload the UI, restart the graphics engine, and clear the game cache." .. "|r")

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