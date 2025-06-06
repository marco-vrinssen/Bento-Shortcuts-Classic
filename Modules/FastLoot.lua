-- Register lootEventFrame for loot detection and processing

local function closeEmptyLootWindow()
    if GetNumLootItems() == 0 then
        CloseLoot()
    end
end

-- Execute auto loot for all available slots

local function handleAutoLoot()
    if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
        local itemCount = GetNumLootItems()
        for slotIndex = itemCount, 1, -1 do
            LootSlot(slotIndex)
        end
    end
end

local lootEventFrame = CreateFrame("Frame")
lootEventFrame:RegisterEvent("LOOT_READY")
lootEventFrame:RegisterEvent("LOOT_OPENED")
lootEventFrame:SetScript("OnEvent", function(self, event)
    if event == "LOOT_READY" then
        handleAutoLoot()
    elseif event == "LOOT_OPENED" then
        closeEmptyLootWindow()
    end
end)