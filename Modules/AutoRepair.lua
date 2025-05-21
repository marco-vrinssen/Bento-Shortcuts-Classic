-- FUNCTION TO AUTO REPAIR ITEMS

local function repairItems()
  if CanMerchantRepair() then
    RepairAllItems()
  end
end

local autoRepairEvents = CreateFrame("Frame")
autoRepairEvents:RegisterEvent("MERCHANT_SHOW")
autoRepairEvents:SetScript("OnEvent", repairItems)