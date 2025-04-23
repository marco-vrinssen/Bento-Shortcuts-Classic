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

-- WHISPER RECENT PLAYERS

local recentWhispers = {}
local whisperedPlayers = {}

local function handleWhisperLastN(msg)
    local num, message = msg:match("^(%d+)%s+(.+)$")

    if not message then
        message = msg
        num = #recentWhispers
    else
        num = tonumber(num)
    end

    if #recentWhispers == 0 then
        print("No players have whispered you yet.")
        return
    end

    if num and message and message ~= "" then
        local whispered = {}
        for i = math.max(#recentWhispers - num + 1, 1), #recentWhispers do
            local playerName = recentWhispers[i]
            if playerName and not whispered[playerName] and not whisperedPlayers[playerName] then
                SendChatMessage(message, "WHISPER", nil, playerName)
                whispered[playerName] = true
                whisperedPlayers[playerName] = true
            end
        end
    else
        print("Usage: /r+ MESSAGE or /r+ N MESSAGE")
    end
end

SLASH_MULTIREPLY1 = "/r+"
SlashCmdList["MULTIREPLY"] = handleWhisperLastN

-- TRACK RECENT WHISPERS

local function trackWhispers(_, _, msg, playerName)
    if not recentWhispers[playerName] then
        table.insert(recentWhispers, playerName)
    end

    if #recentWhispers > 100 then
        table.remove(recentWhispers, 1)
    end
end

local latestWhispEvents = CreateFrame("Frame")
latestWhispEvents:RegisterEvent("CHAT_MSG_WHISPER")
latestWhispEvents:SetScript("OnEvent", function(_, _, msg, sender)
    trackWhispers(_, _, msg, sender)
end)