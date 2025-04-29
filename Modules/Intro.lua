-- DISPLAY LOGIN MESSAGE

local function commandsIntro()
    print(BentoChatColors.YELLOW_LUA.."/bentoshortcuts|r for available commands.")
end

local introFrame = CreateFrame("Frame")
introFrame:RegisterEvent("PLAYER_LOGIN")
introFrame:SetScript("OnEvent", commandsIntro)

-- RENDER COMMAND LIST TOOLTIP

local function showCommandList()
    local tt = _G["CommandListTooltip"]
        or CreateFrame("GameTooltip","CommandListTooltip",UIParent,"GameTooltipTemplate")
    tt:ClearLines()
    tt:SetOwner(UIParent,"ANCHOR_NONE")
    tt:SetPoint("CENTER",UIParent,"CENTER")
    tt:SetMovable(true); tt:EnableMouse(true)
    tt:RegisterForDrag("LeftButton")
    tt:SetScript("OnDragStart",tt.StartMoving)
    tt:SetScript("OnDragStop",tt.StopMovingOrSizing)
    tt:SetResizable(true)

    tt:AddLine(BentoChatColors.YELLOW_LUA.."BENTO COMMANDS|r")
    tt:AddLine(" ")

    tt:AddLine(BentoChatColors.YELLOW_LUA.."KEYWORD SCANNING|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/scan KEYWORD|r"..BentoChatColors.WHITE_LUA..": Monitor channels for keyword.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/scan stop|r"..BentoChatColors.WHITE_LUA..": Stop and clear filters.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/scan clear|r"..BentoChatColors.WHITE_LUA..": Stop and clear filters.|r")
    tt:AddLine(" ")

    tt:AddLine(BentoChatColors.YELLOW_LUA.."MULTI MESSAGING|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/w+ MESSAGE|r"..BentoChatColors.WHITE_LUA..": Whisper all /who results.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/w+ N MESSAGE|r"..BentoChatColors.WHITE_LUA..": Whisper first N /who results.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/w+ -CLASS MESSAGE|r"..BentoChatColors.WHITE_LUA..": Exclude class from whispers.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/r+ MESSAGE|r"..BentoChatColors.WHITE_LUA..": Reply to recent whisper senders.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/r+ N MESSAGE|r"..BentoChatColors.WHITE_LUA..": Reply to last N whisper senders.|r")
    tt:AddLine(" ")

    tt:AddLine(BentoChatColors.YELLOW_LUA.."LFG BROADCAST|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/lfg MESSAGE|r"..BentoChatColors.WHITE_LUA..": Broadcast to World & LFG channels.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/ws MESSAGE|r"..BentoChatColors.WHITE_LUA..": Whisper all current auction sellers.|r")
    tt:AddLine(" ")

    tt:AddLine(BentoChatColors.YELLOW_LUA.."PLAYER TARGETING|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/find NAME|r"..BentoChatColors.WHITE_LUA..": Create FIND macro for NAME.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/find|r"..BentoChatColors.WHITE_LUA..": Create FIND macro for current target.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/find+ NAME|r"..BentoChatColors.WHITE_LUA..": Add NAME to FIND macro.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/find+|r"..BentoChatColors.WHITE_LUA..": Add current target to FIND macro.|r")
    tt:AddLine(" ")

    tt:AddLine(BentoChatColors.YELLOW_LUA.."PORTAL FINDING|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/port ZONE|r"..BentoChatColors.WHITE_LUA..": Find warlock summons to ZONE.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/port|r"..BentoChatColors.WHITE_LUA..": Find mage portals in current zone.|r")
    tt:AddLine(" ")

    tt:AddLine(BentoChatColors.YELLOW_LUA.."GROUP UTILITY|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/rc|r"..BentoChatColors.WHITE_LUA..": Perform ready check.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/rc+|r"..BentoChatColors.WHITE_LUA..": Initiate role poll.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/mp|r"..BentoChatColors.WHITE_LUA..": Mark tanks & healers in party.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/q|r"..BentoChatColors.WHITE_LUA..": Leave party/raid.|r")
    tt:AddLine(" ")

    tt:AddLine(BentoChatColors.YELLOW_LUA.."SYSTEM COMMANDS|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/errors|r"..BentoChatColors.WHITE_LUA..": Toggle Lua error display.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/ui|r"..BentoChatColors.WHITE_LUA..": Reload UI.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/gx|r"..BentoChatColors.WHITE_LUA..": Restart graphics engine.|r")
    tt:AddLine(BentoChatColors.YELLOW_LUA.."/rl|r"..BentoChatColors.WHITE_LUA..": Full reload (UI, graphics, cache).|r")

    tt:Show()
    local btn = CreateFrame("Button",nil,tt,"UIPanelCloseButton")
    btn:SetPoint("TOPRIGHT",tt,"TOPRIGHT")
    btn:SetScript("OnClick",function() tt:Hide() end)
end

SLASH_BENTOSHORTCUTS1 = "/bentoshortcuts"
SlashCmdList["BENTOSHORTCUTS"] = function(msg)
    if msg == "" then showCommandList() end
end