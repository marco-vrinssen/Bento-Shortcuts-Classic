-- WHISPER ALL PLAYERS IN /WHO COMMAND

local function whisperWhoPlayers(msg)
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

    local numWhos = C_FriendList.GetNumWhoResults()

    if limit then
        limit = tonumber(limit)
    else
        limit = numWhos
    end

    if classExclusion then
        classExclusion = classExclusion:lower()
    end

    if message and message ~= "" and numWhos and numWhos > 0 then
        local count = 0
        for i = 1, numWhos do
            if count >= limit then break end
            local info = C_FriendList.GetWhoInfo(i)
            if info and info.fullName then
                if classExclusion then
                    if info.classStr:lower() ~= classExclusion then
                        SendChatMessage(message, "WHISPER", nil, info.fullName)
                        count = count + 1
                    end
                else
                    SendChatMessage(message, "WHISPER", nil, info.fullName)
                    count = count + 1
                end
            end
        end
    end
end


-- REGISTER SLASH COMMANDS

SLASH_WHISPERWHO1 = "/ww"
SlashCmdList["WHISPERWHO"] = whisperWhoPlayers






-- WHISPER ALL AUCTION HOUSE SELLERS

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
        print("Usage: /wl MESSAGE or /wl N MESSAGE")
    end
end

SLASH_WHISPERLASTN1 = "/wl"
SlashCmdList["WHISPERLASTN"] = handleWhisperLastN

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