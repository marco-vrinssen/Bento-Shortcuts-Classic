-- Define debounce variables for secure looting

local lootDelayTimestamp = 0
local lootDebounceInterval = 0.05

-- Execute auto loot for all available slots with debounce to prevent disconnects

local function handleSecureAutoLoot()
    if GetTime() - lootDelayTimestamp >= lootDebounceInterval then
        lootDelayTimestamp = GetTime()
        if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
            local itemCount = GetNumLootItems()
            for slotIndex = itemCount, 1, -1 do
                LootSlot(slotIndex)
            end
        end
    end
end

-- Close loot window if no items remain

local function closeEmptyLootWindow()
    if GetNumLootItems() == 0 then
        CloseLoot()
    end
end

-- Register lootEventFrame for loot detection and processing

local lootEventFrame = CreateFrame("Frame")
lootEventFrame:RegisterEvent("LOOT_READY")
lootEventFrame:RegisterEvent("LOOT_OPENED")
lootEventFrame:SetScript("OnEvent", function(self, event)
    if event == "LOOT_READY" then
        handleSecureAutoLoot()
    elseif event == "LOOT_OPENED" then
        closeEmptyLootWindow()
    end
end)