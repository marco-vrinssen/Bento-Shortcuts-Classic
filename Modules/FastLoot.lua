-- AUTO LOOT ITEMS WHEN LOOT WINDOW OPENS

local function closeEmptyLootWindow()
    if GetNumLootItems() == 0 then
        CloseLoot()
    end
end

local function handleAutoLoot()
    if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
        local numLootItems = GetNumLootItems()
        for lootSlotIndex = numLootItems, 1, -1 do
            LootSlot(lootSlotIndex)
        end
    end
end

-- HANDLE LOOT WINDOW EVENTS

local function onLootEvent(self, event)
    if event == "LOOT_READY" then
        handleAutoLoot()
    elseif event == "LOOT_OPENED" then
        closeEmptyLootWindow()
    end
end

local fastLootFrame = CreateFrame("Frame")
fastLootFrame:RegisterEvent("LOOT_READY")
fastLootFrame:RegisterEvent("LOOT_OPENED")
fastLootFrame:SetScript("OnEvent", onLootEvent)