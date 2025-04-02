local function sendAuctionMessages(msg)
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

SLASH_WSELLER1 = "/deal"
SlashCmdList["WSELLER"] = sendAuctionMessages