-- Initialize regionNames for macro generation

local regionNames = {"us", "kr", "eu", "tw", "cn"}
local currentRegion = regionNames[GetCurrentRegion()]
local FIND_PLUS_ICON = "Ability_Hunter_MarkedForDeath"

-- Create createFindMacros to generate FIND and FIND+ macros for a target

local function createFindMacros(targetInput)
    local macroName = "FIND"
    local macroPlusName = "FIND+"
    local macroBodyFind
    local macroBodyFindPlus
    local targetName

    if targetInput and targetInput ~= "" then
        targetName = targetInput
        macroBodyFind = "/cleartarget\n/target " .. targetInput
    else
        targetName = UnitName("target")
        if targetName then
            macroBodyFind = "/cleartarget\n/target " .. targetName
        else
            print("No target selected and no name provided.")
            return
        end
    end

    macroBodyFindPlus = macroBodyFind .. "\n/run if UnitExists(\"target\") and not UnitIsDead(\"target\") and GetRaidTargetIndex(\"target\") == nil then SetRaidTarget(\"target\",8) end"

    local macroIndexFind = GetMacroIndexByName(macroName)
    if macroIndexFind > 0 then
        EditMacro(macroIndexFind, macroName, "Ability_Hunter_SniperShot", macroBodyFind)
    else
        CreateMacro(macroName, "Ability_Hunter_SniperShot", macroBodyFind, nil)
    end

    local macroIndexFindPlus = GetMacroIndexByName(macroPlusName)
    if macroIndexFindPlus > 0 then
        EditMacro(macroIndexFindPlus, macroPlusName, FIND_PLUS_ICON, macroBodyFindPlus)
    else
        CreateMacro(macroPlusName, FIND_PLUS_ICON, macroBodyFindPlus, nil)
    end

    print(YELLOW_LIGHT_LUA .. "FIND:" .. "|r" .. " " .. targetName .. ".")
end

SLASH_TARGETMACRO1 = "/find"
SlashCmdList["TARGETMACRO"] = createFindMacros

-- Create addToFindPlusMacro to add a target to FIND and FIND+ macros

local function addToFindPlusMacro(targetInput)
    local macroName = "FIND"
    local macroPlusName = "FIND+"
    local macroIndexFind = GetMacroIndexByName(macroName)
    local macroIndexFindPlus = GetMacroIndexByName(macroPlusName)
    local macroBodyFind = macroIndexFind > 0 and GetMacroBody(macroName) or ""
    local macroBodyFindPlus = macroIndexFindPlus > 0 and GetMacroBody(macroPlusName) or ""
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
    for target in macroBodyFind:gmatch("/target ([^\n]+)") do
        table.insert(existingTargets, target)
    end

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

    macroBodyFindPlus = macroBodyFind .. "\n/run if UnitExists(\"target\") and not UnitIsDead(\"target\") and GetRaidTargetIndex(\"target\") == nil then SetRaidTarget(\"target\",8) end"

    if macroIndexFind > 0 then
        EditMacro(macroIndexFind, macroName, "Ability_Hunter_SniperShot", macroBodyFind)
    else
        CreateMacro(macroName, "Ability_Hunter_SniperShot", macroBodyFind, nil)
    end

    if macroIndexFindPlus > 0 then
        EditMacro(macroIndexFindPlus, macroPlusName, FIND_PLUS_ICON, macroBodyFindPlus)
    else
        CreateMacro(macroPlusName, FIND_PLUS_ICON, macroBodyFindPlus, nil)
    end

    local targetsDisplay = table.concat(existingTargets, ", ")
    if targetsDisplay ~= "" then
        targetsDisplay = targetsDisplay .. ", " .. targetName
    else
        targetsDisplay = targetName
    end
    print(YELLOW_LIGHT_LUA .. "FIND:" .. "|r" .. " " .. targetsDisplay .. ".")
end

SLASH_TARGETMACROADD1 = "/find+"
SlashCmdList["TARGETMACROADD"] = addToFindPlusMacro

-- Create triggerFindMacroWithName to call createFindMacros with a player name

local function triggerFindMacroWithName(playerName)
    createFindMacros(playerName)
end

-- Create triggerFindPlusMacroWithName to call addToFindPlusMacro with a player name

local function triggerFindPlusMacroWithName(playerName)
    addToFindPlusMacro(playerName)
end

-- Create assistPlayer to generate an assist macro for a target

local function assistPlayer(targetName)
    if not targetName then
        targetName = UnitName("target")
        if not targetName then
            print("Please provide a NAME after the command ")
            return false
        end
    end

    local macroName = "ASSIST"
    local macroBody = "/assist " .. targetName

    local macroIndex = GetMacroIndexByName(macroName)
    if macroIndex > 0 then
        EditMacro(macroIndex, macroName, "Ability_DualWield", macroBody)
    else
        CreateMacro(macroName, "Ability_DualWield", macroBody, nil)
    end

    print(YELLOW_LIGHT_LUA .. "ASSIST macro updated to" .. "|r" .. " " .. targetName .. ".")
    return true
end

-- Create fixServerName to normalize server names for URLs

local function fixServerName(serverName)
    if serverName == nil or serverName == "" then
        return
    end
    local auServerDetected
    if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC and serverName:sub(-3):lower() == "-au" then
        auServerDetected = true
        serverName = serverName:sub(1, -4)
    end
    serverName = serverName:gsub(""(%u)", function(c) return c:lower() end):gsub(""", ""):gsub("%u", "-%1"):gsub("^[-%s]+", ""):gsub("[^%w%s%-]", ""):gsub("%s", "-"):lower():gsub("%-+", "-")
    serverName = serverName:gsub("([a-zA-Z])of%-", "%1-of-")
    if auServerDetected == true then
        serverName = serverName .. "-au"
    end
    return serverName
end

-- Create generateURL to build armory URLs for a player

local function generateURL(linkType, playerName, serverName)
    local generatedUrl
    if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
        if linkType == "armory" then
            generatedUrl = "https://www.classic-armory.org/character/"..currentRegion.."/vanilla/"..serverName.."/"..playerName
        end
    elseif WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
        if linkType == "armory" then
            generatedUrl = "https://worldofwarcraft.blizzard.com/character/"..currentRegion.."/"..serverName.."/"..playerName
        end
    end
    return generatedUrl
end

-- Create popupLink to show a popup with an armory link

local function popupLink(linkType, playerName, serverName)
    local linkTypeLocal = linkType
    local playerNameLocal = playerName and playerName:lower()
    local serverNameLocal = fixServerName(serverName)

    local generatedUrl = generateURL(linkTypeLocal, playerNameLocal, serverNameLocal)
    if not generatedUrl then return end
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
    StaticPopup_Show("PopupLinkDialog", "", "", {url = generatedUrl})
end

-- Configure context menu for supported unit types to add targeting and player link actions

local supportedUnitTypes = {
    "SELF",
    "PLAYER",
    "PARTY",
    "RAID",
    "RAID_PLAYER",
    "ENEMY_PLAYER",
    "FOCUS",
    "FRIEND",
    "GUILD",
    "GUILD_OFFLINE",
    "ARENAENEMY",
    "BN_FRIEND",
    "CHAT_ROSTER",
    "COMMUNITIES_GUILD_MEMBER",
    "COMMUNITIES_WOW_MEMBER",
    "ENEMY_NPC",
    "ENEMY_UNIT",
    "NPC",
    "PET",
    "TARGET"
}

for _, unitType in ipairs(supportedUnitTypes) do
    Menu.ModifyMenu("MENU_UNIT_"..unitType, function(owner, rootDescription, contextData)
        local serverNameLocal = contextData.server or GetNormalizedRealmName()

        rootDescription:CreateDivider()
        rootDescription:CreateTitle("Targeting")
        rootDescription:CreateButton("Assist", function()
            assistPlayer(contextData.name)
        end)
        rootDescription:CreateButton("Find", function()
            triggerFindMacroWithName(contextData.name)
        end)
        rootDescription:CreateButton("Find+", function()
            triggerFindPlusMacroWithName(contextData.name)
        end)

        rootDescription:CreateDivider()
        rootDescription:CreateTitle("Player Links")
        rootDescription:CreateButton("Armory Link", function()
            popupLink("armory", contextData.name, serverNameLocal)
        end)
    end)
end

-- Configure context menu for chat players to add targeting and player link actions

Menu.ModifyMenu("MENU_CHAT_PLAYER", function(owner, rootDescription, contextData)
    local playerNameLocal = contextData.name

    rootDescription:CreateDivider()
    rootDescription:CreateTitle("Targeting")
    rootDescription:CreateButton("Assist", function()
        assistPlayer(playerNameLocal)
    end)
    rootDescription:CreateButton("Find", function()
        triggerFindMacroWithName(playerNameLocal)
    end)
    rootDescription:CreateButton("Find+", function()
        triggerFindPlusMacroWithName(playerNameLocal)
    end)

    rootDescription:CreateDivider()
    rootDescription:CreateTitle("Player Links")
    rootDescription:CreateButton("Armory Link", function()
        popupLink("armory", playerNameLocal, GetNormalizedRealmName())
    end)
end)