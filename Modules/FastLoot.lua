-- AUTO LOOT ITEMS WHEN LOOT WINDOW OPENS

local function autoLooting()
    if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
        for lootSlotIndex = GetNumLootItems(), 1, -1 do
            LootSlot(lootSlotIndex)
        end
    end
end

local autoLootEvents = CreateFrame("Frame")
autoLootEvents:RegisterEvent("LOOT_READY")
autoLootEvents:SetScript("OnEvent", autoLooting)