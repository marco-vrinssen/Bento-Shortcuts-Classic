-- WHISPER PLAYERS IN /WHO LIST

local function whisperPlayers(msg)
    
    local limit, classExclusion, message

    limit, classExclusion, message = msg:match("^(%d+)%s*-%s*(%w+)%s+(.+)$")
    if not limit then
        limit, message = msg:match("^(%d+)%s+(.+)$")
        if not limit then
            classExclusion, message = msg:match("^%-(%w+)%s+(.+)$")
            if not classExclusion then
                message = msg
            end
        end
    end

    local numWhoResults = C_FriendList.GetNumWhoResults()

    if limit then
        limit = tonumber(limit)
    else
        limit = numWhoResults
    end

    if classExclusion then
        classExclusion = classExclusion:lower()
    end

    if message and message ~= "" and numWhoResults and numWhoResults > 0 then
        local whisperCount = 0
        for i = 1, numWhoResults do
            if whisperCount >= limit then break end
            local whoInfo = C_FriendList.GetWhoInfo(i)
            if whoInfo and whoInfo.fullName then
                if classExclusion then
                    if whoInfo.classStr:lower() ~= classExclusion then
                        SendChatMessage(message, "WHISPER", nil, whoInfo.fullName)
                        whisperCount = whisperCount + 1
                    end
                else
                    SendChatMessage(message, "WHISPER", nil, whoInfo.fullName)
                    whisperCount = whisperCount + 1
                end
            end
        end
    end
end

SLASH_MULTIWHISPER1 = "/w+"
SlashCmdList["MULTIWHISPER"] = whisperPlayers

-- SEND MESSAGES TO AUCTION SELLERS

local function sendAuctionMessages(msg)
    
    if not msg or msg == "" then
        print("Usage: /wah <message>")
        return
    end

    local auctionItemCount = GetNumAuctionItems("list")
    
    for i = 1, auctionItemCount do
        local _, _, _, _, _, _, _, _, _, _, _, _, _, auctionOwner = GetAuctionItemInfo("list", i)
        
        if auctionOwner then
            SendChatMessage(msg, "WHISPER", nil, auctionOwner)
        end
    end
end

SLASH_WSELLER1 = "/ws"
SlashCmdList["WSELLER"] = sendAuctionMessages