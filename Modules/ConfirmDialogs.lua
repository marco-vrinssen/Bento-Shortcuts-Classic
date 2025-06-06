-- Update loot roll handler to auto confirm loot roll dialogs

local function confirmLootRollDialog(_, _, lootId, rollType)
    ConfirmLootRoll(lootId, rollType)
    StaticPopup_Hide("CONFIRM_LOOT_ROLL")
end

local lootRollDialogFrame = CreateFrame("Frame")
lootRollDialogFrame:RegisterEvent("CONFIRM_LOOT_ROLL")
lootRollDialogFrame:SetScript("OnEvent", confirmLootRollDialog)

-- Update loot bind handler to auto confirm loot bind dialogs

local function confirmLootBindDialog(_, _, slotId, bindType, ...)
    ConfirmLootSlot(slotId, bindType)
    StaticPopup_Hide("LOOT_BIND", ...)
end

local lootBindDialogFrame = CreateFrame("Frame")
lootBindDialogFrame:RegisterEvent("LOOT_BIND_CONFIRM")
lootBindDialogFrame:SetScript("OnEvent", confirmLootBindDialog)

-- Update merchant timer handler to auto sell cursor item

local function autoSellCursorItem()
    SellCursorItem()
end

local merchantTimerFrame = CreateFrame("Frame")
merchantTimerFrame:RegisterEvent("MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL")
merchantTimerFrame:SetScript("OnEvent", autoSellCursorItem)

-- Update mail lock handler to auto respond send items

local function respondMailLockSendItemDialog(_, _, mailId)
    RespondMailLockSendItem(mailId, true)
end

local mailLockDialogFrame = CreateFrame("Frame")
mailLockDialogFrame:RegisterEvent("MAIL_LOCK_SEND_ITEMS")
mailLockDialogFrame:SetScript("OnEvent", respondMailLockSendItemDialog)

-- Update equip bind handler to auto equip items

local function confirmEquipBindDialog(_, _, itemId)
    EquipPendingItem(itemId)
    StaticPopup_Hide("EQUIP_BIND")
end

local equipBindDialogFrame = CreateFrame("Frame")
equipBindDialogFrame:RegisterEvent("EQUIP_BIND_CONFIRM")
equipBindDialogFrame:SetScript("OnEvent", confirmEquipBindDialog)

-- Update equip tradeable handler to auto accept bind

local function confirmEquipTradeableDialog(_, _, itemId)
    StaticPopupDialogs["EQUIP_BIND_TRADEABLE"]:OnAccept(itemId)
    StaticPopup_Hide("EQUIP_BIND_TRADEABLE")
end

local equipTradeableDialogFrame = CreateFrame("Frame")
equipTradeableDialogFrame:RegisterEvent("EQUIP_BIND_TRADEABLE_CONFIRM")
equipTradeableDialogFrame:SetScript("OnEvent", confirmEquipTradeableDialog)