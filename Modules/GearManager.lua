if not BentoShortcutsClassicDB then
    BentoShortcutsClassicDB = {}
end

-- SLASH COMMANDS

SLASH_GEARSET1  = "/gearset"
SLASH_EQUIPSET1 = "/equipset"

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

-- SAVE GEAR SET

local function SaveGearSet(setName)
  if setName == "" then
    print("Usage: /gearset SetName")
    return
  end

  local gearSetTable = {}
  for slotID = 1, 19 do
    local itemID = GetInventoryItemID("player", slotID)
    if itemID then
      gearSetTable[slotID] = itemID
    end
  end

  BentoShortcutsClassicDB[setName] = gearSetTable

  print(YELLOW_LIGHT_LUA .. "[GEAR MANAGER]:|r " .. WHITE_LUA .. setName .. " Saved|r")
end

-- EQUIP GEAR SET

local function EquipGearSet(setName)
  if setName == "" then
    print("Usage: /equipset SetName")
    return
  end

  local set = BentoShortcutsClassicDB[setName]
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
        table.insert(missingItems, GetItemNameByID(wantedID))
      end
    end
  end

  if #missingItems > 0 then
    print(
      YELLOW_LIGHT_LUA .. "[GEAR MANAGER]:|r " ..
      WHITE_LUA .. setName .. " not equipped because " ..
      table.concat(missingItems, ", ") .. " is missing|r"
    )
  else
    print(
      YELLOW_LIGHT_LUA .. "[GEAR MANAGER]:|r " ..
      WHITE_LUA .. setName .. " Equipped|r"
    )
  end
end

-- SLASH COMMAND HOOKS

SlashCmdList["GEARSET"] = function(msg)
  SaveGearSet(trim(msg))
end

SlashCmdList["EQUIPSET"] = function(msg)
  EquipGearSet(trim(msg))
end