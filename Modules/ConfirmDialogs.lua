-- AUTOMATICALLY CONFIRM LOOT ROLL DIALOGS

local function handleLootRollConfirmation(_, _, lootRollIdentifier, rollTypeSelected)
    ConfirmLootRoll(lootRollIdentifier, rollTypeSelected)
    StaticPopup_Hide("CONFIRM_LOOT_ROLL")
end
local lootRollConfirmationFrame = CreateFrame("Frame")
lootRollConfirmationFrame:RegisterEvent("CONFIRM_LOOT_ROLL")
lootRollConfirmationFrame:SetScript("OnEvent", handleLootRollConfirmation)

-- AUTOMATICALLY CONFIRM LOOT BIND DIALOGS

local function handleLootBindConfirmation(_, _, slotIdentifier, bindTypeSelected, ...)
    ConfirmLootSlot(slotIdentifier, bindTypeSelected)
    StaticPopup_Hide("LOOT_BIND", ...)
end
local lootBindConfirmationFrame = CreateFrame("Frame")
lootBindConfirmationFrame:RegisterEvent("LOOT_BIND_CONFIRM")
lootBindConfirmationFrame:SetScript("OnEvent", handleLootBindConfirmation)

-- AUTOMATICALLY CONFIRM MERCHANT TRADE TIMER REMOVAL

local function handleMerchantTradeTimerRemoval()
    SellCursorItem()
end
local merchantTradeTimerConfirmationFrame = CreateFrame("Frame")
merchantTradeTimerConfirmationFrame:RegisterEvent("MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL")
merchantTradeTimerConfirmationFrame:SetScript("OnEvent", handleMerchantTradeTimerRemoval)

-- AUTOMATICALLY CONFIRM MAIL LOCK SEND ITEMS

local function handleMailLockSendItemsConfirmation(_, _, mailItemIdentifier)
    RespondMailLockSendItem(mailItemIdentifier, true)
end
local mailLockSendItemsConfirmationFrame = CreateFrame("Frame")
mailLockSendItemsConfirmationFrame:RegisterEvent("MAIL_LOCK_SEND_ITEMS")
mailLockSendItemsConfirmationFrame:SetScript("OnEvent", handleMailLockSendItemsConfirmation)

-- AUTOMATICALLY CONFIRM EQUIP BIND DIALOGS

local function handleEquipBindConfirmation(_, _, itemIdentifier)
    EquipPendingItem(itemIdentifier)
    StaticPopup_Hide("EQUIP_BIND")
end
local equipBindConfirmationFrame = CreateFrame("Frame")
equipBindConfirmationFrame:RegisterEvent("EQUIP_BIND_CONFIRM")
equipBindConfirmationFrame:SetScript("OnEvent", handleEquipBindConfirmation)

-- AUTOMATICALLY CONFIRM EQUIP BIND TRADEABLE DIALOGS

local function handleEquipBindTradeableConfirmation(_, _, itemIdentifier)
    StaticPopupDialogs["EQUIP_BIND_TRADEABLE"]:OnAccept(itemIdentifier)
    StaticPopup_Hide("EQUIP_BIND_TRADEABLE")
end
local equipBindTradeableConfirmationFrame = CreateFrame("Frame")
equipBindTradeableConfirmationFrame:RegisterEvent("EQUIP_BIND_TRADEABLE_CONFIRM")
equipBindTradeableConfirmationFrame:SetScript("OnEvent", handleEquipBindTradeableConfirmation)