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

    macroBody = macroBody .. "\n/run if UnitExists(\"target\") and not UnitIsDead(\"target\") and not GetRaidTargetIndex(\"target\") then SetRaidTarget(\"target\",8) end"

    local macroIndex = GetMacroIndexByName(macroName)
    if macroIndex > 0 then
        EditMacro(macroIndex, macroName, "Ability_Hunter_SniperShot", macroBody)
    else
        CreateMacro(macroName, "Ability_Hunter_SniperShot", macroBody, nil)
    end

    print(YELLOW_CHAT_LUA .. "FIND:" .. "|r" .. " " .. targetName .. ".")
end

SLASH_TARGETMACRO1 = "/fm"
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

    macroBody = macroBody .. "\n/run if UnitExists(\"target\") and not UnitIsDead(\"target\") and not GetRaidTargetIndex(\"target\") then SetRaidTarget(\"target\",8) end"

    if macroIndex > 0 then
        EditMacro(macroIndex, macroName, "Ability_Hunter_SniperShot", macroBody)
    else
        CreateMacro(macroName, "Ability_Hunter_SniperShot", macroBody, nil)
    end

    local newTargetsStr = table.concat(existingTargets, ", ") .. ", " .. targetName
    print(YELLOW_CHAT_LUA .. "FIND:" .. "|r" .. " " .. newTargetsStr .. ".")
end

SLASH_TARGETMACROADD1 = "/fm+"
SlashCmdList["TARGETMACROADD"] = addToTargetMacro

-- ASSIST MACRO FUNCTION

local function createAssistMacro(msg)
    local macroName = "ASSIST"
    local macroBody
    local targetName

    if msg and msg ~= "" then
        targetName = msg
        macroBody = "/assist " .. msg
    else
        targetName = UnitName("target")
        if targetName then
            macroBody = "/assist " .. targetName
        else
            print("No target selected and no name provided.")
            return
        end
    end

    local macroIndex = GetMacroIndexByName(macroName)
    if macroIndex > 0 then
        EditMacro(macroIndex, macroName, "Ability_DualWield", macroBody)
    else
        CreateMacro(macroName, "Ability_DualWield", macroBody, nil)
    end

    print(YELLOW_CHAT_LUA .. "ASSIST:" .. "|r" .. " " .. targetName .. ".")
end

SLASH_ASSISTMACRO1 = "/am"
SlashCmdList["ASSISTMACRO"] = createAssistMacro