-- Enable command intro message for user guidance

local function showCommandIntroMsg()
    print(YELLOW_LIGHT_LUA .. "/bentoshortcuts" .. "|r" .. " for available commands.")
end

local loginEventFrame = CreateFrame("Frame")
loginEventFrame:RegisterEvent("PLAYER_LOGIN")
loginEventFrame:SetScript("OnEvent", showCommandIntroMsg)

-- Show command list in tooltip for user reference

local function showCommandListTooltip()
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

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Bento Shortcuts Classic" .. "|r", 1, 1, 1, true)
    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Chat & Communication" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/cs KEYWORD" .. "|r" .. WHITE_LUA .. " Monitor chat for keyword" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/cs stop" .. "|r" .. WHITE_LUA .. " Stop scanning" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/ww MESSAGE" .. "|r" .. WHITE_LUA .. " Whisper all in /who list" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/ww N MESSAGE" .. "|r" .. WHITE_LUA .. " Whisper first N players" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/ww -CLASS MSG" .. "|r" .. WHITE_LUA .. " Exclude class" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/ww+ MESSAGE" .. "|r" .. WHITE_LUA .. " Whisper with ignore list" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/clearskiplist" .. "|r" .. WHITE_LUA .. " Clear whisper ignore list" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/rr MESSAGE" .. "|r" .. WHITE_LUA .. " Reply to recent whispers" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/rr N MESSAGE" .. "|r" .. WHITE_LUA .. " Reply to last N senders" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/wt MESSAGE" .. "|r" .. WHITE_LUA .. " Whisper current target" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/wt+ MESSAGE" .. "|r" .. WHITE_LUA .. " Whisper target with ignore" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/lfg MESSAGE" .. "|r" .. WHITE_LUA .. " Broadcast to World/LFG" .. "|r")
    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Gear Management" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/gearset NAME" .. "|r" .. WHITE_LUA .. " Save current gear set" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/equipset NAME" .. "|r" .. WHITE_LUA .. " Equip saved gear set" .. "|r")
    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Player Targeting" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/find NAME" .. "|r" .. WHITE_LUA .. " Create find macro" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/find" .. "|r" .. WHITE_LUA .. " Find current target" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/find+ NAME" .. "|r" .. WHITE_LUA .. " Add to find macro" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/alsofind NAME" .. "|r" .. WHITE_LUA .. " Alt add to find macro" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/assist NAME" .. "|r" .. WHITE_LUA .. " Create assist macro" .. "|r")
    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Travel & Portals" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/port ZONE" .. "|r" .. WHITE_LUA .. " Find summons to zone" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/port" .. "|r" .. WHITE_LUA .. " Find portals in zone" .. "|r")
    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Group Management" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/rc" .. "|r" .. WHITE_LUA .. " Ready check" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/rc+" .. "|r" .. WHITE_LUA .. " Role check" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/q" .. "|r" .. WHITE_LUA .. " Leave party/raid" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/mp" .. "|r" .. WHITE_LUA .. " Mark party by role" .. "|r")
    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "System & Interface" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/errors" .. "|r" .. WHITE_LUA .. " Toggle Lua errors" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/ui" .. "|r" .. WHITE_LUA .. " Reload interface" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/gx" .. "|r" .. WHITE_LUA .. " Restart graphics" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/rl" .. "|r" .. WHITE_LUA .. " Full reload" .. "|r")
    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Sound Management" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/mutesound ID" .. "|r" .. WHITE_LUA .. " Mute sound by ID" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/mutesound clear" .. "|r" .. WHITE_LUA .. " Unmute all" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/mutesound check" .. "|r" .. WHITE_LUA .. " List muted" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/mutesound default" .. "|r" .. WHITE_LUA .. " Restore defaults" .. "|r")
    tooltip:AddLine(" ")

    tooltip:AddLine(YELLOW_LIGHT_LUA .. "Automation" .. "|r")
    tooltip:AddLine(YELLOW_LIGHT_LUA .. "/ts" .. "|r" .. WHITE_LUA .. " Toggle tracking switcher" .. "|r")
    tooltip:AddLine(WHITE_LUA .. "Auto sell junk, repair, fast loot" .. "|r")
    tooltip:AddLine(WHITE_LUA .. "Auto-confirm loot and bind dialogs" .. "|r")
    tooltip:AddLine(WHITE_LUA .. "Ctrl+I to copy names" .. "|r")
    tooltip:AddLine(WHITE_LUA .. "Right-click main menu to reload UI" .. "|r")
    tooltip:AddLine(WHITE_LUA .. "Context menus with Armory links" .. "|r")

    tooltip:Show()

    local closeBtn = CreateFrame("Button", nil, tooltip, "UIPanelCloseButton")
    closeBtn:SetPoint("TOPRIGHT", tooltip, "TOPRIGHT")
    closeBtn:SetScript("OnClick", function()
        tooltip:Hide()
    end)
end

-- Register slash command for showing command list tooltip

SLASH_BENTOSHORTCUTS1 = "/bentoshortcuts"
SlashCmdList["BENTOSHORTCUTS"] = function(msg, editBox)
    if msg == "" then
        showCommandListTooltip()
    end
end