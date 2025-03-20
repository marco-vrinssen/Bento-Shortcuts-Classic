-- WHISPER ALL AUCTION HOUSE SELLERS

SLASH_WAUCTION1 = "/wah"

function SendAuctionMessages(msg)
    if not msg or msg == "" then
        print("Usage: /wah <message>")
        return
    end

    local numItems = GetNumAuctionItems("list")
    
    for i = 1, numItems do
        local _, _, _, _, _, _, _, _, _, _, _, _, _, owner = GetAuctionItemInfo("list", i)
        
        if owner then
            SendChatMessage(msg, "WHISPER", nil, owner)
        end
    end
end

SlashCmdList["WAUCTION"] = SendAuctionMessages