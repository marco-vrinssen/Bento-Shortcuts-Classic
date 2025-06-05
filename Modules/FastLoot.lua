-- INITIALIZE TIMING VARIABLES FOR DEBOUNCE CONTROL

local lootTime = 0
local lootDelay = 0.05

-- CLOSE EMPTY LOOT WINDOW TO PREVENT INTERFACE CLUTTER

local function closeEmptyLootWindow()
    if GetNumLootItems() == 0 then
        CloseLoot()
    end
end

-- EXECUTE AUTO LOOT WITH TIME DELAY VALIDATION

local function handleAutoLoot()
    if GetTime() - lootTime >= lootDelay then
        lootTime = GetTime()
        if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
            local itemCount = GetNumLootItems()
            for slotIndex = itemCount, 1, -1 do
                LootSlot(slotIndex)
            end
        end
    end
end

-- REGISTER EVENT FRAME FOR LOOT DETECTION AND PROCESSING

local lootFrame = CreateFrame("Frame")
lootFrame:RegisterEvent("LOOT_READY")
lootFrame:RegisterEvent("LOOT_OPENED")
lootFrame:SetScript("OnEvent", function(self, event)
    if event == "LOOT_READY" then
        handleAutoLoot()
    elseif event == "LOOT_OPENED" then
        closeEmptyLootWindow()
    end
end)