-- Prevent disconnects by debouncing loot actions

local lootDelayTime = 0
local lootDebounceTime = 0.005

-- Securely loot all available slots if auto loot is enabled

local function lootAllSlots()
    if GetTime() - lootDelayTime >= lootDebounceTime then
        lootDelayTime = GetTime()
        if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
            local lootItemCount = GetNumLootItems()
            for lootSlotIndex = lootItemCount, 1, -1 do
                LootSlot(lootSlotIndex)
            end
        end
    end
end

-- Close the loot window if there are no items left

local function closeEmptyLootWindow()
    if GetNumLootItems() == 0 then
        CloseLoot()
    end
end

-- Register frame to handle loot events

local lootEventFrame = CreateFrame("Frame")
lootEventFrame:RegisterEvent("LOOT_READY")
lootEventFrame:RegisterEvent("LOOT_OPENED")
lootEventFrame:SetScript("OnEvent", function(_, event)
    if event == "LOOT_READY" then
        lootAllSlots()
    elseif event == "LOOT_OPENED" then
        closeEmptyLootWindow()
    end
end)