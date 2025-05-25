if not BentoShortcutsClassicDB then
    BentoShortcutsClassicDB = {}
end

-- REGISTER SLASH COMMANDS

SLASH_GEARSET1  = "/gearset"
SLASH_EQUIPSET1 = "/equipset"


-- IMPLEMENT STRING UTILITIES

local function trim(inputString)
  return inputString and inputString:match("^%s*(.-)%s*$") or ""
end

-- SETUP CONTAINER API COMPATIBILITY

local GetNumSlots, GetLink, UseItem, PickupContainerItemFunc
if GetContainerNumSlots then
  GetNumSlots = GetContainerNumSlots
  GetLink = GetContainerItemLink
  UseItem = UseContainerItem
  PickupContainerItemFunc = PickupContainerItem
elseif C_Container then
  GetNumSlots = C_Container.GetContainerNumSlots
  GetLink = C_Container.GetContainerItemLink
  UseItem = C_Container.UseContainerItem
  PickupContainerItemFunc = C_Container.PickupContainerItem
else
  error("No container API found!")
end


-- DEFINE SLOT MAPPINGS

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

-- IMPLEMENT ITEM UTILITIES

local function GetItemNameByID(itemID)
  local itemName = GetItemInfo(itemID)
  if itemName then
    return itemName
  end
  return ("ItemID:%d"):format(itemID)
end

-- IMPLEMENT GEAR SET SAVING

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

  print(YELLOW_LIGHT_LUA .. "[Gear Set Manager]:|r " .. WHITE_LUA .. setName .. " Set Saved|r")
end

-- IMPLEMENT GEAR SET EQUIPPING

local function EquipGearSet(setName)
  if setName == "" then
    print("Usage: /equipset SetName")
    return
  end

  if type(BentoShortcutsClassicDB.GearSets) ~= "table" then
    BentoShortcutsClassicDB.GearSets = {}
  end

  local gearSet = BentoShortcutsClassicDB.GearSets[setName]
  if not gearSet then
    print(("No gear set named '%s' found."):format(setName))
    return
  end

  if InCombatLockdown() then
    print("Cannot swap gear while in combat.")
    return
  end

  local missingItems = {}

  for slotID, wantedItemID in pairs(gearSet) do
    local equippedItemID = GetInventoryItemID("player", slotID)
    if equippedItemID ~= wantedItemID then
      local itemFound = false
      for bagIndex = 0, 4 do
        local bagSlotCount = GetNumSlots(bagIndex) or 0
        for bagSlot = 1, bagSlotCount do
          local itemLink = GetLink(bagIndex, bagSlot)
          if itemLink then
            local bagItemID = tonumber(itemLink:match("item:(%d+):"))
            if bagItemID == wantedItemID then
              if CursorHasItem() then
                ClearCursor()
              end
              
              PickupContainerItemFunc(bagIndex, bagSlot)
              PickupInventoryItem(slotID)
              
              itemFound = true
              break
            end
          end
        end
        if itemFound then break end
      end
      if not itemFound then
        table.insert(missingItems, GetItemNameByID(wantedItemID))
      end
    end
  end

  if #missingItems > 0 then
    print(
      YELLOW_LIGHT_LUA .. "[Gear Set Manager]:|r " ..
      WHITE_LUA .. setName .. " not equipped because " ..
      table.concat(missingItems, ", ") .. " is missing|r"
    )
  else
    print(
      YELLOW_LIGHT_LUA .. "[Gear Set Manager]:|r " ..
      WHITE_LUA .. setName .. " Set Equipped|r"
    )
  end
end

-- REGISTER COMMAND HANDLERS

SlashCmdList["GEARSET"] = function(commandMessage)
  SaveGearSet(trim(commandMessage))
end

SlashCmdList["EQUIPSET"] = function(commandMessage)
  EquipGearSet(trim(commandMessage))
end
