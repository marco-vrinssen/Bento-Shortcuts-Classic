-- FUNCTION TO SELL GREY (JUNK) ITEMS

local function sellGreyItems()
  for bag = 0, 4 do
      for slot = 1, C_Container.GetContainerNumSlots(bag) do
          local itemLink = C_Container.GetContainerItemLink(bag, slot)
          if itemLink then
              local _, _, itemRarity, _, _, _, _, _, _, _, _ = GetItemInfo(itemLink)
              local itemCount = select(2, C_Container.GetContainerItemInfo(bag, slot)) or 0
              if itemRarity == 0 then
                  C_Container.UseContainerItem(bag, slot)
              end
          end
      end
  end
end

local autoSellEvents = CreateFrame("Frame")
autoSellEvents:RegisterEvent("MERCHANT_SHOW")
autoSellEvents:SetScript("OnEvent", sellGreyItems)