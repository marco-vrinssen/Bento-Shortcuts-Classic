-- Initialize regionNames for URL generation

local regionNames = {'us', 'kr', 'eu', 'tw', 'cn'}
local currentRegion = regionNames[GetCurrentRegion()]

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
    serverName = serverName:gsub("'(%u)", function(c) return c:lower() end):gsub("'", ""):gsub("%u", "-%1"):gsub("^[-%s]+", ""):gsub("[^%w%s%-]", ""):gsub("%s", "-"):lower():gsub("%-+", "-")
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

-- Expose functions for use by context menus

BentoShortcuts = BentoShortcuts or {}
BentoShortcuts.ArmoryLinks = BentoShortcuts.ArmoryLinks or {}

BentoShortcuts.ArmoryLinks.popupLink = popupLink
