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
            BentoShortcuts.MacroTargeting.assistPlayer(contextData.name)
        end)
        rootDescription:CreateButton("Find", function()
            BentoShortcuts.MacroTargeting.createFindMacros(contextData.name)
        end)
        rootDescription:CreateButton("Find+", function()
            BentoShortcuts.MacroTargeting.addToFindPlusMacro(contextData.name)
        end)

        rootDescription:CreateDivider()
        rootDescription:CreateTitle("Player Links")
        rootDescription:CreateButton("Armory Link", function()
            BentoShortcuts.ArmoryLinks.popupLink("armory", contextData.name, serverNameLocal)
        end)
    end)
end

-- Configure context menu for chat players to add targeting and player link actions

Menu.ModifyMenu("MENU_CHAT_PLAYER", function(owner, rootDescription, contextData)
    local playerNameLocal = contextData.name

    rootDescription:CreateDivider()
    rootDescription:CreateTitle("Targeting")
    rootDescription:CreateButton("Assist", function()
        BentoShortcuts.MacroTargeting.assistPlayer(playerNameLocal)
    end)
    rootDescription:CreateButton("Find", function()
        BentoShortcuts.MacroTargeting.createFindMacros(playerNameLocal)
    end)
    rootDescription:CreateButton("Find+", function()
        BentoShortcuts.MacroTargeting.addToFindPlusMacro(playerNameLocal)
    end)

    rootDescription:CreateDivider()
    rootDescription:CreateTitle("Player Links")
    rootDescription:CreateButton("Armory Link", function()
        BentoShortcuts.ArmoryLinks.popupLink("armory", playerNameLocal, GetNormalizedRealmName())
    end)
end)
