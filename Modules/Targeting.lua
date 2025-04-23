-- CONSTANTS

local regionNames = {'us', 'kr', 'eu', 'tw', 'cn'}
local region = regionNames[GetCurrentRegion()]


-- DEFINE NAME OR TARGET FOR FIND MACRO

local function createTargetMacro(msg)
    local macroName = "FIND"
    local macroBody
    local targetName

    if msg and msg ~= "" then
        targetName = msg
        macroBody = "/cleartarget\n/target " .. msg
    else
        targetName = UnitName("target")
        if targetName then
            macroBody = "/cleartarget\n/target " .. targetName
        else
            print("No target selected and no name provided.")
            return
        end
    end

    macroBody = macroBody .. "\n/run if UnitExists(\"target\") and not UnitIsDead(\"target\") and GetRaidTargetIndex(\"target\") == nil then SetRaidTarget(\"target\",8) end"

    local macroIndex = GetMacroIndexByName(macroName)
    if macroIndex > 0 then
        EditMacro(macroIndex, macroName, "Ability_Hunter_SniperShot", macroBody)
    else
        CreateMacro(macroName, "Ability_Hunter_SniperShot", macroBody, nil)
    end

    print(YELLOW_CHAT_LUA .. "FIND:" .. "|r" .. " " .. targetName .. ".")
end

SLASH_TARGETMACRO1 = "/find"
SlashCmdList["TARGETMACRO"] = createTargetMacro


-- ADD NAME OR TARGET TO FIND MACRO

local function addToTargetMacro(msg)
    local macroName = "FIND"
    local macroIndex = GetMacroIndexByName(macroName)
    local macroBody = macroIndex > 0 and GetMacroBody(macroName) or ""
    local targetName

    if msg and msg ~= "" then
        targetName = msg
    else
        targetName = UnitName("target")
        if not targetName then
            print("No target selected and no name provided.")
            return
        end
    end

    local existingTargets = {}
    for target in macroBody:gmatch("/target ([^\n]+)") do
        table.insert(existingTargets, target)
    end

    for _, target in ipairs(existingTargets) do
        if target == targetName then
            print(targetName .. " is already in the target list.")
            return
        end
    end

    if #existingTargets >= 3 then
        print("Cannot add more than 3 targets.")
        return
    end

    if macroBody == "" or not macroBody:find("/cleartarget") then
        macroBody = "/cleartarget\n/target " .. targetName
    else
        macroBody = macroBody:gsub("\n/run .+", "") .. "\n/target " .. targetName
    end

    macroBody = macroBody .. "\n/run if UnitExists(\"target\") and not UnitIsDead(\"target\") and GetRaidTargetIndex(\"target\") == nil then SetRaidTarget(\"target\",8) end"

    if macroIndex > 0 then
        EditMacro(macroIndex, macroName, "Ability_Hunter_SniperShot", macroBody)
    else
        CreateMacro(macroName, "Ability_Hunter_SniperShot", macroBody, nil)
    end

    local newTargetsStr = table.concat(existingTargets, ", ") .. ", " .. targetName
    print(YELLOW_CHAT_LUA .. "FIND:" .. "|r" .. " " .. newTargetsStr .. ".")
end

SLASH_TARGETMACROADD1 = "/find+"
SlashCmdList["TARGETMACROADD"] = addToTargetMacro


-- TRIGGER FIND MACRO WITH CONTEXT DATA NAME

local function triggerFindMacroWithName(playerName)
    createTargetMacro(playerName)
end


-- TRIGGER FIND ALSO MACRO WITH CONTEXT DATA NAME

local function triggerFindAlsoMacroWithName(playerName)
    addToTargetMacro(playerName)
end


-- ASSIST PLAYER

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
    
    print(YELLOW_CHAT_LUA .. "ASSIST macro updated to" .. "|r" .. " " .. targetName .. ".")
    return true
end


-- FIX SERVER NAME

local function fixServerName(server)
    if server == nil or server == "" then
        return
    end
    local auServer
    if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC and server:sub(-3):lower() == "-au" then
        auServer = true
        server = server:sub(1, -4)
    end
    server = server:gsub("'(%u)", function(c) return c:lower() end):gsub("'", ""):gsub("%u", "-%1"):gsub("^[-%s]+", ""):gsub("[^%w%s%-]", ""):gsub("%s", "-"):lower():gsub("%-+", "-")
    server = server:gsub("([a-zA-Z])of%-", "%1-of-")
    if auServer == true then
        server = server .. "-au"
    end
    return server
end


-- GENERATE URL

local function generateURL(type, name, server)
    local url
    if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
        if type == "armory" then
            url = "https://www.classic-armory.org/character/"..region.."/vanilla/"..server.."/"..name
        end
    elseif WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
        if type == "armory" then
            url = "https://worldofwarcraft.blizzard.com/character/"..region.."/"..server.."/"..name
        end
    end
    return url
end


-- POPUP LINK

local function popupLink(argType, argName, argServer)
    local type = argType
    local name = argName and argName:lower()
    local server = fixServerName(argServer)

    local url = generateURL(type, name, server)
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
                local isMac = IsMacClient()
                if key == "ESCAPE" then
                    self:Hide()
                elseif (isMac and IsMetaKeyDown() or IsControlKeyDown()) and key == "C" then
                    self:Hide()
                end
            end)
        end,
    }
    StaticPopup_Show("PopupLinkDialog", "", "", {url = url})
end


-- MODIFY MENU

local chatTypes = {
    "SELF", "PLAYER", "PARTY", "RAID", "RAID_PLAYER", "ENEMY_PLAYER",
    "FOCUS", "FRIEND", "GUILD", "GUILD_OFFLINE", "ARENAENEMY",
    "BN_FRIEND", "CHAT_ROSTER", "COMMUNITIES_GUILD_MEMBER", "COMMUNITIES_WOW_MEMBER", "ENEMY_NPC", "ENEMY_UNIT", "NPC", "PET", "TARGET"
}

for _, value in ipairs(chatTypes) do
    Menu.ModifyMenu("MENU_UNIT_"..value, function(owner, rootDescription, contextData)
        local server = contextData.server or GetNormalizedRealmName()
        
        rootDescription:CreateDivider()
        rootDescription:CreateTitle("Targeting")
        rootDescription:CreateButton("Assist", function()
            assistPlayer(contextData.name)
        end)
        rootDescription:CreateButton("Find", function()
            triggerFindMacroWithName(contextData.name)
        end)
        rootDescription:CreateButton("Find Also", function()
            triggerFindAlsoMacroWithName(contextData.name)
        end)

        rootDescription:CreateDivider()
        rootDescription:CreateTitle("Player Links")
        rootDescription:CreateButton("Armory Link", function()
            popupLink("armory", contextData.name, server)
        end)
    end)
end

Menu.ModifyMenu("MENU_CHAT_PLAYER", function(owner, rootDescription, contextData)
    local playerName = contextData.name

    rootDescription:CreateDivider()
    rootDescription:CreateTitle("Targeting")
    rootDescription:CreateButton("Assist", function()
        assistPlayer(playerName)
    end)
    rootDescription:CreateButton("Find", function()
        triggerFindMacroWithName(playerName)
    end)
    rootDescription:CreateButton("Find Also", function()
        triggerFindAlsoMacroWithName(playerName)
    end)

    rootDescription:CreateDivider()
    rootDescription:CreateTitle("Player Links")
    rootDescription:CreateButton("Armory Link", function()
        popupLink("armory", playerName, GetNormalizedRealmName())
    end)
end)