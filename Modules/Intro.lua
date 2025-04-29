-- LOGIN MESSAGE DISPLAY

local function commandsIntro()
    print(YELLOW_CHAT_LUA.."/bentoshortcuts|r for available commands.")
end

local introFrame = CreateFrame("Frame")
introFrame:RegisterEvent("PLAYER_LOGIN")
introFrame:SetScript("OnEvent", commandsIntro)


-- COMMAND LIST TOOLTIP

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

    tt:AddLine(YELLOW_CHAT_LUA.."BENTO COMMANDS|r")
    tt:AddLine(" ")

    tt:AddLine(YELLOW_CHAT_LUA.."KEYWORD SCANNING|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/scan KEYWORD|r"..WHITE_CHAT_LUA..": Monitor channels for keyword.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/scan stop|r"..WHITE_CHAT_LUA..": Stop and clear filters.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/scan clear|r"..WHITE_CHAT_LUA..": Stop and clear filters.|r")
    tt:AddLine(" ")

    tt:AddLine(YELLOW_CHAT_LUA.."MULTI MESSAGING|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/w+ MESSAGE|r"..WHITE_CHAT_LUA..": Whisper all /who results.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/w+ N MESSAGE|r"..WHITE_CHAT_LUA..": Whisper first N /who results.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/w+ -CLASS MESSAGE|r"..WHITE_CHAT_LUA..": Exclude class from whispers.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/r+ MESSAGE|r"..WHITE_CHAT_LUA..": Reply to recent whisper senders.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/r+ N MESSAGE|r"..WHITE_CHAT_LUA..": Reply to last N whisper senders.|r")
    tt:AddLine(" ")

    tt:AddLine(YELLOW_CHAT_LUA.."LFG BROADCAST|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/lfg MESSAGE|r"..WHITE_CHAT_LUA..": Broadcast to World & LFG channels.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/ws MESSAGE|r"..WHITE_CHAT_LUA..": Whisper all current auction sellers.|r")
    tt:AddLine(" ")

    tt:AddLine(YELLOW_CHAT_LUA.."PLAYER TARGETING|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/find NAME|r"..WHITE_CHAT_LUA..": Create FIND macro for NAME.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/find|r"..WHITE_CHAT_LUA..": Create FIND macro for current target.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/find+ NAME|r"..WHITE_CHAT_LUA..": Add NAME to FIND macro.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/find+|r"..WHITE_CHAT_LUA..": Add current target to FIND macro.|r")
    tt:AddLine(" ")

    tt:AddLine(YELLOW_CHAT_LUA.."PORTAL FINDING|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/port ZONE|r"..WHITE_CHAT_LUA..": Find warlock summons to ZONE.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/port|r"..WHITE_CHAT_LUA..": Find mage portals in current zone.|r")
    tt:AddLine(" ")

    tt:AddLine(YELLOW_CHAT_LUA.."GROUP UTILITY|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/rc|r"..WHITE_CHAT_LUA..": Perform ready check.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/rc+|r"..WHITE_CHAT_LUA..": Initiate role poll.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/mp|r"..WHITE_CHAT_LUA..": Mark tanks & healers in party.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/q|r"..WHITE_CHAT_LUA..": Leave party/raid.|r")
    tt:AddLine(" ")

    tt:AddLine(YELLOW_CHAT_LUA.."SYSTEM COMMANDS|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/errors|r"..WHITE_CHAT_LUA..": Toggle Lua error display.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/ui|r"..WHITE_CHAT_LUA..": Reload UI.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/gx|r"..WHITE_CHAT_LUA..": Restart graphics engine.|r")
    tt:AddLine(YELLOW_CHAT_LUA.."/rl|r"..WHITE_CHAT_LUA..": Full reload (UI, graphics, cache).|r")

    tt:Show()
    local btn = CreateFrame("Button",nil,tt,"UIPanelCloseButton")
    btn:SetPoint("TOPRIGHT",tt,"TOPRIGHT")
    btn:SetScript("OnClick",function() tt:Hide() end)
end

SLASH_BENTOSHORTCUTS1 = "/bentoshortcuts"
SlashCmdList["BENTOSHORTCUTS"] = function(msg)
    if msg == "" then showCommandList() end
end