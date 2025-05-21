-- AUTO CONFIRM LOOT ROLL

local function autoConfirmLootRoll(_, _, lootRollID, rollType)
    ConfirmLootRoll(lootRollID, rollType)
    StaticPopup_Hide("CONFIRM_LOOT_ROLL")
end

local lootRollFrame = CreateFrame("Frame")
lootRollFrame:RegisterEvent("CONFIRM_LOOT_ROLL")
lootRollFrame:SetScript("OnEvent", autoConfirmLootRoll)


-- AUTO CONFIRM LOOT BIND

local function autoConfirmLootBind(_, _, slotID, bindType, ...)
    ConfirmLootSlot(slotID, bindType)
    StaticPopup_Hide("LOOT_BIND", ...)
end

local lootBindFrame = CreateFrame("Frame")
lootBindFrame:RegisterEvent("LOOT_BIND_CONFIRM")
lootBindFrame:SetScript("OnEvent", autoConfirmLootBind)


-- AUTO CONFIRM MERCHANT TRADE TIMER REMOVAL

local function autoConfirmMerchantTradeTimerRemoval()
    SellCursorItem()
end

local merchantTradeTimerFrame = CreateFrame("Frame")
merchantTradeTimerFrame:RegisterEvent("MERCHANT_CONFIRM_TRADE_TIMER_REMOVAL")
merchantTradeTimerFrame:SetScript("OnEvent", autoConfirmMerchantTradeTimerRemoval)


-- AUTO CONFIRM MAIL LOCK SEND ITEMS

local function autoConfirmMailLockSendItems(_, _, mailItemID)
    RespondMailLockSendItem(mailItemID, true)
end

local mailLockSendFrame = CreateFrame("Frame")
mailLockSendFrame:RegisterEvent("MAIL_LOCK_SEND_ITEMS")
mailLockSendFrame:SetScript("OnEvent", autoConfirmMailLockSendItems)


-- AUTO CONFIRM EQUIP BIND

local function autoConfirmEquipBind(_, _, itemID)
    EquipPendingItem(itemID)
    StaticPopup_Hide("EQUIP_BIND")
end

local equipBindFrame = CreateFrame("Frame")
equipBindFrame:RegisterEvent("EQUIP_BIND_CONFIRM")
equipBindFrame:SetScript("OnEvent", autoConfirmEquipBind)


-- AUTO CONFIRM EQUIP BIND TRADEABLE

local function autoConfirmEquipBindTradeable(_, _, itemID)
    StaticPopupDialogs["EQUIP_BIND_TRADEABLE"]:OnAccept(itemID)
    StaticPopup_Hide("EQUIP_BIND_TRADEABLE")
end

local equipBindTradeableFrame = CreateFrame("Frame")
equipBindTradeableFrame:RegisterEvent("EQUIP_BIND_TRADEABLE_CONFIRM")
equipBindTradeableFrame:SetScript("OnEvent", autoConfirmEquipBindTradeable)


-- AUTO CONFIRM DELETE ITEM

local function autoConfirmDeleteItem()
    DeleteCursorItem()
end

local deleteItemFrame = CreateFrame("Frame")
deleteItemFrame:RegisterEvent("DELETE_ITEM_CONFIRM")
deleteItemFrame:SetScript("OnEvent", autoConfirmDeleteItem)