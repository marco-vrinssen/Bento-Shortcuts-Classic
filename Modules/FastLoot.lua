-- Initialize debounce variables to prevent disconnects

local delayTimestamp = 0
local debounceInterval = 0.01

-- Process auto loot slots to enable secure looting

local function processAutoLoot()
    if GetTime() - delayTimestamp >= debounceInterval then
        delayTimestamp = GetTime()
        if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
            local itemCount = GetNumLootItems()
            for slotIndex = itemCount, 1, -1 do
                LootSlot(slotIndex)
            end
        end
    end
end

-- Close loot window to handle empty containers

local function closeLootWindow()
    if GetNumLootItems() == 0 then
        CloseLoot()
    end
end

-- Register event frame for loot detection

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("LOOT_READY")
eventFrame:RegisterEvent("LOOT_OPENED")
eventFrame:SetScript("OnEvent", function(self, event)
    if event == "LOOT_READY" then
        processAutoLoot()
    elseif event == "LOOT_OPENED" then
        closeLootWindow()
    end
end)