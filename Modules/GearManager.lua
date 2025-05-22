if not BentoShortcutsClassicDB then
    BentoShortcutsClassicDB = {}
end

-- SLASH COMMANDS

SLASH_SETGEAR1 = "/set"
SLASH_EQUIPGEAR1 = "/equip"

-- TRIM HELPER

local function trim(s)
  return s and s:match("^%s*(.-)%s*$") or ""
end

-- CONTAINER API PICKER

local GetNumSlots, GetLink, UseItem
if GetContainerNumSlots then
  GetNumSlots = GetContainerNumSlots
  GetLink    = GetContainerItemLink
  UseItem    = UseContainerItem
elseif C_Container then
  GetNumSlots = C_Container.GetContainerNumSlots
  GetLink    = C_Container.GetContainerItemLink
  UseItem    = C_Container.UseContainerItem
else
  error("No container API found!")
end

-- COLOR CONSTANTS

local YELLOW_LIGHT_LUA = "|cFFFDE89B"
local WHITE_LUA = "|cFFFFFFFF"

-- SLOTID TO SLOTNAME MAP

local SLOTID_TO_SLOTNAME = {
  [1] = "HeadSlot",
  [2] = "NeckSlot",
  [3] = "ShoulderSlot",
  [4] = "ShirtSlot",
  [5] = "ChestSlot",
  [6] = "WaistSlot",
  [7] = "LegsSlot",
  [8] = "FeetSlot",
  [9] = "WristSlot",
  [10] = "HandsSlot",
  [11] = "Finger0Slot",
  [12] = "Finger1Slot",
  [13] = "Trinket0Slot",
  [14] = "Trinket1Slot",
  [15] = "BackSlot",
  [16] = "MainHandSlot",
  [17] = "SecondaryHandSlot",
  [18] = "RangedSlot",
  [19] = "TabardSlot"
}

-- GET ITEM NAME BY ITEMID

local function GetItemNameByID(itemID)
  local itemName = GetItemInfo(itemID)
  if itemName then
    return itemName
  end
  return ("ItemID:%d"):format(itemID)
end

-- GEAR SET MANAGER SAVED MESSAGE

local function PrintGearSetSavedMessage(gearSetName)
  print(YELLOW_LIGHT_LUA .. "[Gear Set Manager]:|r Set " .. gearSetName .. " saved.")
end

-- GEAR SET MANAGER EQUIPPED MESSAGE

local function PrintGearSetEquippedMessage(gearSetName)
  print(YELLOW_LIGHT_LUA .. "[Gear Set Manager]:|r Set " .. gearSetName .. " equipped.")
end

-- GEAR SET MANAGER ITEM MISSING MESSAGE

local function PrintGearSetItemMissingMessage(itemName)
  print(YELLOW_LIGHT_LUA .. "[Gear Set Manager]:|r Item " .. itemName .. " missing.")
end

-- GEAR SET MANAGER USAGE MESSAGE

local function printSetGearUsage()
  print(YELLOW_LIGHT_LUA .. "[Set Gear]:|r /set NAME")
end

local function printEquipGearUsage()
  print(YELLOW_LIGHT_LUA .. "[Equip Gear]:|r /equip NAME")
end

-- GEAR SETS STORED AS SUBTABLES IN BENTOSHORTCUTSCLASSICDB.GEARSETS

local function SaveGearSet(setName)
  if setName == "" then
    print("Usage: /gearset SetName")
    return
  end

  if type(BentoShortcutsClassicDB.GearSets) ~= "table" then
    BentoShortcutsClassicDB.GearSets = {}
  end

  if type(BentoShortcutsClassicDB.GearSets[setName]) ~= "table" then
    BentoShortcutsClassicDB.GearSets[setName] = {}
  end

  for slotID = 1, 19 do
    local itemID = GetInventoryItemID("player", slotID)
    if itemID then
      BentoShortcutsClassicDB.GearSets[setName][slotID] = itemID
    else
      BentoShortcutsClassicDB.GearSets[setName][slotID] = nil
    end
  end

  PrintGearSetSavedMessage(setName)
end

local function EquipGearSet(setName)
  if setName == "" then
    print("Usage: /equipset SetName")
    return
  end

  if type(BentoShortcutsClassicDB.GearSets) ~= "table" then
    BentoShortcutsClassicDB.GearSets = {}
  end

  local set = BentoShortcutsClassicDB.GearSets[setName]
  if not set then
    print(("No gear set named '%s' found."):format(setName))
    return
  end

  if InCombatLockdown() then
    print("Cannot swap gear while in combat.")
    return
  end

  local missingItems = {}

  for slotID, wantedID in pairs(set) do
    local equipped = GetInventoryItemID("player", slotID)
    if equipped ~= wantedID then
      local found = false
      for bag = 0, 4 do
        local num = GetNumSlots(bag) or 0
        for bs = 1, num do
          local link = GetLink(bag, bs)
          if link then
            local id = tonumber(link:match("item:(%d+):"))
            if id == wantedID then
              UseItem(bag, bs)
              found = true
              break
            end
          end
        end
        if found then break end
      end
      if not found then
        local itemName = GetItemNameByID(wantedID)
        PrintGearSetItemMissingMessage(itemName)
        table.insert(missingItems, itemName)
      end
    end
  end

  if #missingItems == 0 then
    PrintGearSetEquippedMessage(setName)
  end
end

-- SLASH COMMAND HOOKS

SlashCmdList["SETGEAR"] = function(msg)
  if trim(msg) == "" then
    printSetGearUsage()
    return
  end
  SaveGearSet(trim(msg))
end

SlashCmdList["EQUIPGEAR"] = function(msg)
  if trim(msg) == "" then
    printEquipGearUsage()
    return
  end
  EquipGearSet(trim(msg))
end