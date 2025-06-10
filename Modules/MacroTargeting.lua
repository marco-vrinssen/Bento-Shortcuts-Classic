-- Initialize variables for macro generation

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

-- Create assistPlayer to generate an assist macro for a target

local function assistPlayer(targetInput)
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
        print(YELLOW_LIGHT_LUA .. "ASSIST macro updated to" .. "|r" .. " " .. targetName .. ".")
    else
        CreateMacro(macroName, "Ability_DualWield", macroBody, nil)
        print(YELLOW_LIGHT_LUA .. "ASSIST macro created for" .. "|r" .. " " .. targetName .. ".")
    end
    
    return true
end

SLASH_ASSISTMACRO1 = "/assist"
SlashCmdList["ASSISTMACRO"] = assistPlayer

-- Expose functions for use by context menus

BentoShortcuts = BentoShortcuts or {}
BentoShortcuts.MacroTargeting = BentoShortcuts.MacroTargeting or {}

BentoShortcuts.MacroTargeting.createFindMacros = createFindMacros
BentoShortcuts.MacroTargeting.addToFindPlusMacro = addToFindPlusMacro
BentoShortcuts.MacroTargeting.assistPlayer = assistPlayer
