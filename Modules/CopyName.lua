local frame = CreateFrame("Frame", "ItemNameFrame", UIParent)

StaticPopupDialogs["ITEM_NAME_POPUP"] = {
    text = "Name of Item or Unit",
    button1 = "Close",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    hasEditBox = true,
    OnShow = function(self, data)
        self.editBox:SetText(data.name)
        self.editBox:HighlightText()
        self.editBox:SetFocus()
        self.editBox:SetScript("OnKeyDown", function(_, key)
            local isMac = IsMacClient()
            if key == "ESCAPE" then
                self:Hide()
            elseif (isMac and IsMetaKeyDown() or IsControlKeyDown()) and key == "C" then
                self:Hide()
            end
        end)
    end,
}

local function showNamePopup(name)
    if name then
        C_Timer.After(0.1, function()
            StaticPopup_Show("ITEM_NAME_POPUP", "", "", {name = name})
        end)
    else
        print("No item or NPC is being hovered over.")
    end
end

-- GET HOVERED NAME OR TARGET NAME
local function getHoveredOrTargetName()
    local name, link = GameTooltip:GetItem()
    if name then return name end

    name = UnitName("target")
    if name then return name end

    return nil
end

frame:SetScript("OnUpdate", function(self, elapsed)
    if GameTooltip:IsVisible() then
        self.hoveredName = getHoveredOrTargetName()
    else
        self.hoveredName = nil
    end
end)

local keyFrame = CreateFrame("Frame", "KeyDetectFrame", UIParent)
keyFrame:SetPropagateKeyboardInput(true)
keyFrame:SetScript("OnKeyDown", function(self, key)
    local isMac = IsMacClient()
    if key == "I" and (IsControlKeyDown() or (isMac and IsMetaKeyDown())) then
        showNamePopup(frame.hoveredName)
        keyFrame:SetPropagateKeyboardInput(false)
        C_Timer.After(0.1, function() keyFrame:SetPropagateKeyboardInput(true) end)
        return
    end
end)

keyFrame:EnableKeyboard(true)
keyFrame:SetPoint("CENTER")
keyFrame:SetSize(1, 1)