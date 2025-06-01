-- WHISPER RECENT PLAYERS

local recentWhispersList = {}
local recentWhispersSet = {}
local whisperedPlayersSet = {}
local maxRecentWhispers = 50

local function handleWhisperLastN(receivedMessage)
    local targetCount, messageToSend = receivedMessage:match("^(%d+)%s+(.+)$")

    if not messageToSend then
        messageToSend = receivedMessage
        targetCount = #recentWhispersList
    else
        targetCount = tonumber(targetCount)
    end

    if #recentWhispersList == 0 then
        print("No players have whispered you yet.")
        return
    end

    if targetCount and messageToSend and messageToSend ~= "" then
        local currentSessionWhispered = {}
        local startIndex = math.max(#recentWhispersList - targetCount + 1, 1)
        
        for i = startIndex, #recentWhispersList do
            local targetPlayer = recentWhispersList[i]
            if targetPlayer and not currentSessionWhispered[targetPlayer] and not whisperedPlayersSet[targetPlayer] then
                SendChatMessage(messageToSend, "WHISPER", nil, targetPlayer)
                currentSessionWhispered[targetPlayer] = true
                whisperedPlayersSet[targetPlayer] = true
            end
        end
    else
        print("Usage: /r+ MESSAGE or /r+ N MESSAGE")
    end
end

SLASH_MULTIREPLY1 = "/r+"
SLASH_MULTIREPLY2 = "/r+ reset"
SlashCmdList["MULTIREPLY"] = function(receivedMessage)
    if receivedMessage == "reset" then
        whisperedPlayersSet = {}
        print("Reset whispered players list. You can now whisper all recent players again.")
    else
        handleWhisperLastN(receivedMessage)
    end
end

-- TRACK RECENT WHISPERS

local function addRecentWhisperer(incomingPlayer)
    if recentWhispersSet[incomingPlayer] then
        for i = 1, #recentWhispersList do
            if recentWhispersList[i] == incomingPlayer then
                table.remove(recentWhispersList, i)
                break
            end
        end
    else
        recentWhispersSet[incomingPlayer] = true
    end
    
    table.insert(recentWhispersList, incomingPlayer)
    
    while #recentWhispersList > maxRecentWhispers do
        local removedPlayer = table.remove(recentWhispersList, 1)
        recentWhispersSet[removedPlayer] = nil
    end
end

local whisperTrackingFrame = CreateFrame("Frame")
whisperTrackingFrame:RegisterEvent("CHAT_MSG_WHISPER")
whisperTrackingFrame:SetScript("OnEvent", function(_, _, receivedMessage, senderName)
    addRecentWhisperer(senderName)
end)