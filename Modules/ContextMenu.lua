-- Merge macro targeting, armory links, and context menu enhancements

local regionNames = {'us', 'kr', 'eu', 'tw', 'cn'}
local currentRegion = regionNames[GetCurrentRegion()]

-- Create normalizeServerName to format server names for URLs

local function normalizeServerName(serverName)
    if not serverName or serverName == "" then return end
    local auDetected
    if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC and serverName:sub(-3):lower() == "-au" then
        auDetected = true
        serverName = serverName:sub(1, -4)
    end
    serverName = serverName:gsub("'(%u)", function(c) return c:lower() end):gsub("'", ""):gsub("%u", "-%1"):gsub("^[-%s]+", ""):gsub("[^%w%s%-]", ""):gsub("%s", "-"):lower():gsub("%-+", "-")
    serverName = serverName:gsub("([a-zA-Z])of%-", "%1-of-")
    if auDetected then serverName = serverName .. "-au" end
    return serverName
end

-- Create buildArmoryUrl to generate armory URLs for a player

local function buildArmoryUrl(linkType, playerName, serverName)
    if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC and linkType == "armory" then
        return "https://www.classic-armory.org/character/"..currentRegion.."/vanilla/"..serverName.."/"..playerName
    elseif WOW_PROJECT_ID == WOW_PROJECT_MAINLINE and linkType == "armory" then
        return "https://worldofwarcraft.blizzard.com/character/"..currentRegion.."/"..serverName.."/"..playerName
    end
end

-- Show a popup with an armory link

local function showArmoryPopup(linkType, playerName, serverName)
    local playerNameLocal = playerName and playerName:lower()
    local serverNameLocal = normalizeServerName(serverName)
    local url = buildArmoryUrl(linkType, playerNameLocal, serverNameLocal)
    if not url then return end
    StaticPopupDialogs["PopupLinkDialog"] = {
        text = "Armory Link",
        button1 = "Close",
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        hasEditBox = true,
        OnShow = function(self, data)
            self.editBox:SetText(data.url)
            self.editBox:HighlightText()
            self.editBox:SetFocus()
            self.editBox:SetScript("OnKeyDown", function(_, key)
                local macDetected = IsMacClient()
                if key == "ESCAPE" then
                    self:Hide()
                elseif (macDetected and IsMetaKeyDown() or IsControlKeyDown()) and key == "C" then
                    self:Hide()
                end
            end)
        end,
    }
    StaticPopup_Show("PopupLinkDialog", "", "", {url = url})
end

-- Update FIND and MARK macros for a target or add a new target

local MARK_ICON = "Ability_Hunter_MarkedForDeath"
local FIND_ICON = "Ability_Hunter_SniperShot"

local function updateTargetMacros(targetInput, addMode)
    local macroFind = "FIND"
    local macroMark = "MARK"
    local macroIndexFind = GetMacroIndexByName(macroFind)
    local macroIndexMark = GetMacroIndexByName(macroMark)
    local macroBodyFind = macroIndexFind > 0 and GetMacroBody(macroFind) or ""
    local macroBodyMark = macroIndexMark > 0 and GetMacroBody(macroMark) or ""
    local targetName

    if targetInput and targetInput ~= "" then
        targetName = targetInput
    else
        targetName = UnitName("target")
        if not targetName then
            print("No target selected and no name provided.")
            return
        end
    end

    local existingTargets = {}
    for t in macroBodyFind:gmatch("/target ([^\n]+)") do
        table.insert(existingTargets, t)
    end

    if addMode then
        for _, existingTarget in ipairs(existingTargets) do
            if existingTarget == targetName then
                print(targetName .. " is already in the target list.")
                return
            end
        end
        if #existingTargets >= 3 then
            print("Cannot add more than 3 targets.")
            return
        end
        if macroBodyFind == "" or not macroBodyFind:find("/cleartarget") then
            macroBodyFind = "/cleartarget\n/target " .. targetName
        else
            macroBodyFind = macroBodyFind:gsub("\n/run .+", "") .. "\n/target " .. targetName
        end
    else
        macroBodyFind = "/cleartarget\n/target " .. targetName
    end

    macroBodyMark = macroBodyFind .. "\n/run if UnitExists(\"target\") and not UnitIsDead(\"target\") and GetRaidTargetIndex(\"target\") == nil then SetRaidTarget(\"target\",8) end"

    if macroIndexFind > 0 then
        EditMacro(macroIndexFind, macroFind, FIND_ICON, macroBodyFind)
    else
        CreateMacro(macroFind, FIND_ICON, macroBodyFind, nil)
    end
    if macroIndexMark > 0 then
        EditMacro(macroIndexMark, macroMark, MARK_ICON, macroBodyMark)
    else
        CreateMacro(macroMark, MARK_ICON, macroBodyMark, nil)
    end

    local targetsDisplay = {}
    for t in macroBodyFind:gmatch("/target ([^\n]+)") do
        table.insert(targetsDisplay, t)
    end
    print(YELLOW_LIGHT_LUA .. "[Find]: " .. "|r" .. table.concat(targetsDisplay, ", ") .. ".")
end

-- Update ASSIST macro for a target

local function updateAssistMacro(targetInput)
    local targetName
    if targetInput and targetInput ~= "" then
        targetName = targetInput
    else
        targetName = UnitName("target")
        if not targetName then
            print("Please provide a NAME after the command or select a target.")
            return false
        end
    end
    local macroName = "ASSIST"
    local macroBody = "/assist " .. targetName
    local macroIndex = GetMacroIndexByName(macroName)
    if macroIndex > 0 then
        EditMacro(macroIndex, macroName, "Ability_DualWield", macroBody)
        print(YELLOW_LIGHT_LUA .. "[Assist]: " .. "|r" .. targetName .. ".")
    else
        CreateMacro(macroName, "Ability_DualWield", macroBody, nil)
        print(YELLOW_LIGHT_LUA .. "[Assist]: " .. "|r" .. targetName .. ".")
    end
    return true
end

-- Register slash commands for macro targeting

SLASH_FINDMACRO1 = "/find"
SlashCmdList["FINDMACRO"] = function(msg)
    updateTargetMacros(msg, false)
end
SLASH_ALSOFINDMACRO1 = "/alsofind"
SlashCmdList["ALSOFINDMACRO"] = function(msg)
    updateTargetMacros(msg, true)
end
SLASH_ASSISTMACRO1 = "/assist"
SlashCmdList["ASSISTMACRO"] = updateAssistMacro

-- Update context menu for supported unit types to add targeting and player link actions

local supportedUnitTypes = {
    "SELF", "PLAYER", "PARTY", "RAID", "RAID_PLAYER", "ENEMY_PLAYER", "FOCUS", "FRIEND", "GUILD", "GUILD_OFFLINE", "ARENAENEMY", "BN_FRIEND", "CHAT_ROSTER", "COMMUNITIES_GUILD_MEMBER", "COMMUNITIES_WOW_MEMBER", "ENEMY_NPC", "ENEMY_UNIT", "NPC", "PET", "TARGET"
}
for _, unitType in ipairs(supportedUnitTypes) do
    Menu.ModifyMenu("MENU_UNIT_"..unitType, function(owner, rootDescription, contextData)
        local serverNameLocal = contextData.server or GetNormalizedRealmName()

        rootDescription:CreateDivider()
        rootDescription:CreateTitle("Targeting")
        rootDescription:CreateButton("Assist", function()
            updateAssistMacro(contextData.name)
        end)
        rootDescription:CreateButton("Find", function()
            updateTargetMacros(contextData.name, false)
        end)
        rootDescription:CreateButton("Also Find", function()
            updateTargetMacros(contextData.name, true)
        end)

        rootDescription:CreateDivider()
        rootDescription:CreateTitle("Player Links")
        rootDescription:CreateButton("Armory Link", function()
            showArmoryPopup("armory", contextData.name, serverNameLocal)
        end)
    end)
end

Menu.ModifyMenu("MENU_CHAT_PLAYER", function(owner, rootDescription, contextData)
    local playerNameLocal = contextData.name

    rootDescription:CreateDivider()
    rootDescription:CreateTitle("Targeting")
    rootDescription:CreateButton("Assist", function()
        updateAssistMacro(playerNameLocal)
    end)
    rootDescription:CreateButton("Find", function()
        updateTargetMacros(playerNameLocal, false)
    end)
    rootDescription:CreateButton("Also Find", function()
        updateTargetMacros(playerNameLocal, true)
    end)

    rootDescription:CreateDivider()
    rootDescription:CreateTitle("Player Links")
    rootDescription:CreateButton("Armory Link", function()
        showArmoryPopup("armory", playerNameLocal, GetNormalizedRealmName())
    end)
end)

-- Expose functions for use by other modules

BentoShortcuts = BentoShortcuts or {}
BentoShortcuts.ContextEnhancements = {
    updateTargetMacros = updateTargetMacros,
    updateAssistMacro = updateAssistMacro,
    showArmoryPopup = showArmoryPopup
}