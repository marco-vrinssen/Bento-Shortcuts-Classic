-- Initialize database if not present for BentoShortcutsClassicDB

if not BentoShortcutsClassicDB then
    BentoShortcutsClassicDB = {}
end

-- Register slash commands for gear set management

SLASH_GEARSET1  = "/gearset"
SLASH_EQUIPSET1 = "/equipset"

-- Implement string trim utility for input sanitization

local function trim(inputString)
  return inputString and inputString:match("^%s*(.-)%s*$") or ""
end

-- Setup container API compatibility for bag operations

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

-- Define slot ID to slot name mapping for gear slots

local slotIdToNameMap = {
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

-- Implement item name lookup utility by item ID

local function getItemNameById(itemId)
  local itemName = GetItemInfo(itemId)
  if itemName then
    return itemName
  end
  return ("ItemID:%d"):format(itemId)
end

-- Save current gear set to database under provided set name

local function saveGearSet(setName)
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

  for slotId = 1, 19 do
    local itemId = GetInventoryItemID("player", slotId)
    if itemId then
      BentoShortcutsClassicDB.GearSets[setName][slotId] = itemId
    else
      BentoShortcutsClassicDB.GearSets[setName][slotId] = nil
    end
  end

  print(YELLOW_LIGHT_LUA .. "[Gear Set Manager]:|r " .. WHITE_LUA .. setName .. " Set Saved|r")
end

-- Equip gear set by set name, swapping items as needed

local function equipGearSet(setName)
  if setName == "" then
    print("Usage: /equipset SetName")
    return
  end

  if type(BentoShortcutsClassicDB.GearSets) ~= "table" then
    BentoShortcutsClassicDB.GearSets = {}
  end

  local gearSet = BentoShortcutsClassicDB.GearSets[setName]
  if not gearSet then
    print(("No gear set named "%s" found."):format(setName))
    return
  end

  if InCombatLockdown() then
    print("Cannot swap gear while in combat.")
    return
  end

  local missingItemList = {}

  for slotId, wantedItemId in pairs(gearSet) do
    local equippedItemId = GetInventoryItemID("player", slotId)
    if equippedItemId ~= wantedItemId then
      local itemFound = false
      for bagIndex = 0, 4 do
        local bagSlotCount = GetNumSlots(bagIndex) or 0
        for bagSlot = 1, bagSlotCount do
          local itemLink = GetLink(bagIndex, bagSlot)
          if itemLink then
            local bagItemId = tonumber(itemLink:match("item:(%d+):"))
            if bagItemId == wantedItemId then
              if CursorHasItem() then
                ClearCursor()
              end
              PickupContainerItemFunc(bagIndex, bagSlot)
              PickupInventoryItem(slotId)
              itemFound = true
              break
            end
          end
        end
        if itemFound then break end
      end
      if not itemFound then
        table.insert(missingItemList, getItemNameById(wantedItemId))
      end
    end
  end

  if #missingItemList > 0 then
    print(
      YELLOW_LIGHT_LUA .. "[Gear Set Manager]:|r " ..
      WHITE_LUA .. setName .. " not equipped because " ..
      table.concat(missingItemList, ", ") .. " is missing|r"
    )
  else
    print(
      YELLOW_LIGHT_LUA .. "[Gear Set Manager]:|r " ..
      WHITE_LUA .. setName .. " Set Equipped|r"
    )
  end
end

-- Register slash command handlers for gear set save and equip

SlashCmdList["GEARSET"] = function(commandMessage)
  saveGearSet(trim(commandMessage))
end

SlashCmdList["EQUIPSET"] = function(commandMessage)
  equipGearSet(trim(commandMessage))
end
