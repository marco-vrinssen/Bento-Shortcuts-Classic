-- ASSIST MACRO FUNCTION

-- EXTRACT CORE ASSIST FUNCTIONALITY

local function assistPlayer(targetName)
    if not targetName then
        targetName = UnitName("target")
        if not targetName then
            print("No target selected and no name provided.")
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
    
    print(YELLOW_CHAT_LUA .. "ASSIST MACRO UPDATED TO:" .. "|r" .. " " .. targetName .. ".")
    return true
end

-- REFACTOR SLASH COMMAND TO USE CORE FUNCTION

local function createAssistMacro(msg)
    assistPlayer(msg ~= "" and msg or nil)
end

SLASH_ASSISTTARGET1 = "/assist+"
SlashCmdList["ASSISTTARGET"] = createAssistMacro

-- ADD RIGHT-CLICK MENU INTEGRATION

local chatTypes = {
    "PLAYER",
    "PARTY",
    "RAID",
    "RAID_PLAYER",
    "FOCUS",
    "FRIEND"
}

for _, value in ipairs(chatTypes) do
    Menu.ModifyMenu("MENU_UNIT_"..value, function(owner, rootDescription, contextData)
        -- Add the Assist button to the menu
        rootDescription:CreateButton("\124cffffffffAssist", function()
            assistPlayer(contextData.name)
        end)
    end)
end