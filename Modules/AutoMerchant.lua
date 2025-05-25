-- FUNCTION TO SELL GREY (JUNK) ITEMS

local function sellGreyItems()
  local soldAnyJunk = false
  for bag = 0, 4 do
      for slot = 1, C_Container.GetContainerNumSlots(bag) do
          local itemLink = C_Container.GetContainerItemLink(bag, slot)
          if itemLink then
              local _, _, itemRarity, _, _, _, _, _, _, _, _ = GetItemInfo(itemLink)
              local itemCount = select(2, C_Container.GetContainerItemInfo(bag, slot)) or 0
              if itemRarity == 0 then
                  C_Container.UseContainerItem(bag, slot)
                  soldAnyJunk = true
              end
          end
      end
  end
  if soldAnyJunk then
    print(YELLOW_LIGHT_LUA .. "[Merchant]:|r Junk Items sold.")
  end
end

-- REGISTER AUTO SELL EVENTS

local autoSellEvents = CreateFrame("Frame")
autoSellEvents:RegisterEvent("MERCHANT_SHOW")
autoSellEvents:SetScript("OnEvent", sellGreyItems)

-- FUNCTION TO AUTO REPAIR ITEMS

local function repairItems()
  if CanMerchantRepair() then
    local repairCost, canRepair = GetRepairAllCost()
    if canRepair and repairCost > 0 then
      RepairAllItems()
      print(YELLOW_LIGHT_LUA .. "[Merchant]:|r Items repaired.")
    end
  end
end

-- REGISTER AUTO REPAIR EVENTS

local autoRepairEvents = CreateFrame("Frame")
autoRepairEvents:RegisterEvent("MERCHANT_SHOW")
autoRepairEvents:SetScript("OnEvent", repairItems)