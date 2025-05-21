-- AUTO LOOT ITEMS WHEN LOOT WINDOW OPENS

local lastLootTime = 0
local LOOT_DELAY = 0.05

local function autoLooting()
    if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
        if (GetTime() - lastLootTime) >= LOOT_DELAY then
            for i = GetNumLootItems(), 1, -1 do
                LootSlot(i)
            end
            lastLootTime = GetTime()
        end
    end
end

local autoLootEvents = CreateFrame("Frame")
autoLootEvents:RegisterEvent("LOOT_READY")
autoLootEvents:SetScript("OnEvent", autoLooting)