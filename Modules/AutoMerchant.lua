-- Update sellJunkItems function to use descriptive naming and reformat comments

-- Register sellJunkItems function to sell junk items when merchant window opens
local function sellJunkItems()
  local soldJunk = false
  for bagIndex = 0, 4 do
    for slotIndex = 1, C_Container.GetContainerNumSlots(bagIndex) do
      local itemLink = C_Container.GetContainerItemLink(bagIndex, slotIndex)
      if itemLink then
        local _, _, itemRarity = GetItemInfo(itemLink)
        local itemCount = select(2, C_Container.GetContainerItemInfo(bagIndex, slotIndex)) or 0
        if itemRarity == 0 then
          C_Container.UseContainerItem(bagIndex, slotIndex)
          soldJunk = true
        end
      end
    end
  end
  if soldJunk then
    print(YELLOW_LIGHT_LUA .. "[Merchant]:|r Junk Items sold.")
  end
end

-- Register autoSellFrame to handle merchant show event for selling junk
local autoSellFrame = CreateFrame("Frame")
autoSellFrame:RegisterEvent("MERCHANT_SHOW")
autoSellFrame:SetScript("OnEvent", sellJunkItems)

-- Update repairAllItems function to use descriptive naming and reformat comments

-- Register repairAllItems function to auto repair when merchant window opens
local function repairAllItems()
  if CanMerchantRepair() then
    local repairCost, canRepair = GetRepairAllCost()
    if canRepair and repairCost > 0 then
      RepairAllItems()
      print(YELLOW_LIGHT_LUA .. "[Merchant]:|r Items repaired.")
    end
  end
end

-- Register autoRepairFrame to handle merchant show event for repairing items
local autoRepairFrame = CreateFrame("Frame")
autoRepairFrame:RegisterEvent("MERCHANT_SHOW")
autoRepairFrame:SetScript("OnEvent", repairAllItems)