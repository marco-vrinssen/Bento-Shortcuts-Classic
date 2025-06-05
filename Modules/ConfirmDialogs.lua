-- HANDLE LOOT ROLL CONFIRMATION TO AUTO CONFIRM DIALOGS

local function handleLootRollConfirmation(_, _, lootId, rollType)
    ConfirmLootRoll(lootId, rollType)
    StaticPopup_Hide("CONFIRM_LOOT_ROLL")
end

local lootRollFrame = CreateFrame("Frame")
lootRollFrame:RegisterEvent("CONFIRM_LOOT_ROLL")
lootRollFrame:SetScript("OnEvent", handleLootRollConfirmation)

-- HANDLE LOOT BIND CONFIRMATION TO AUTO CONFIRM DIALOGS

local function handleLootBindConfirmation(_, _, slotId, bindType, ...)
    ConfirmLootSlot(slotId, bindType)
    StaticPopup_Hide("LOOT_BIND", ...)
end

local lootBindFrame = CreateFrame("Frame")
lootBindFrame:RegisterEvent("LOOT_BIND_CONFIRM")
lootBindFrame:SetScript("OnEvent", handleLootBindConfirmation)

-- HANDLE MERCHANT TIMER REMOVAL TO AUTO SELL CURSOR ITEM

local function handleMerchantTimer()
    SellCursorItem()
end

local merchantFrame = CreateFrame("Frame")
merchantFrame:RegisterEvent("MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL")
merchantFrame:SetScript("OnEvent", handleMerchantTimer)

-- HANDLE MAIL LOCK CONFIRMATION TO AUTO RESPOND SEND ITEMS

local function handleMailLockConfirmation(_, _, mailId)
    RespondMailLockSendItem(mailId, true)
end

local mailLockFrame = CreateFrame("Frame")
mailLockFrame:RegisterEvent("MAIL_LOCK_SEND_ITEMS")
mailLockFrame:SetScript("OnEvent", handleMailLockConfirmation)

-- HANDLE EQUIP BIND CONFIRMATION TO AUTO EQUIP ITEMS

local function handleEquipBindConfirmation(_, _, itemId)
    EquipPendingItem(itemId)
    StaticPopup_Hide("EQUIP_BIND")
end

local equipBindFrame = CreateFrame("Frame")
equipBindFrame:RegisterEvent("EQUIP_BIND_CONFIRM")
equipBindFrame:SetScript("OnEvent", handleEquipBindConfirmation)

-- HANDLE EQUIP TRADEABLE CONFIRMATION TO AUTO ACCEPT BIND

local function handleEquipTradeableConfirmation(_, _, itemId)
    StaticPopupDialogs["EQUIP_BIND_TRADEABLE"]:OnAccept(itemId)
    StaticPopup_Hide("EQUIP_BIND_TRADEABLE")
end

local equipTradeableFrame = CreateFrame("Frame")
equipTradeableFrame:RegisterEvent("EQUIP_BIND_TRADEABLE_CONFIRM")
equipTradeableFrame:SetScript("OnEvent", handleEquipTradeableConfirmation)