-- Initialize and manage recent whisper tracking and multi-reply functionality for chat

local recentWhisperedPlayersList = {}
local recentWhisperedPlayersSet = {}
local alreadyWhisperedPlayersSet = {}
local maxRecentWhisperedPlayers = 50

-- Handle whisper command to send message to last N players

local function handleWhisperToLastPlayers(inputMessage)
    local targetPlayerCount, messageToSend = inputMessage:match("^(%d+)%s+(.+)$")

    if not messageToSend then
        messageToSend = inputMessage
        targetPlayerCount = #recentWhisperedPlayersList
    else
        targetPlayerCount = tonumber(targetPlayerCount)
    end

    if #recentWhisperedPlayersList == 0 then
        print("No players have whispered you yet.")
        return
    end

    if targetPlayerCount and messageToSend and messageToSend ~= "" then
        local sessionWhisperedPlayersSet = {}
        local startIndex = math.max(#recentWhisperedPlayersList - targetPlayerCount + 1, 1)

        for i = startIndex, #recentWhisperedPlayersList do
            local targetPlayerName = recentWhisperedPlayersList[i]
            if targetPlayerName and not sessionWhisperedPlayersSet[targetPlayerName] and not alreadyWhisperedPlayersSet[targetPlayerName] then
                SendChatMessage(messageToSend, "WHISPER", nil, targetPlayerName)
                sessionWhisperedPlayersSet[targetPlayerName] = true
                alreadyWhisperedPlayersSet[targetPlayerName] = true
            end
        end
    else
        print("Usage: /r+ MESSAGE or /r+ N MESSAGE")
    end
end

-- Register slash command for multi-reply functionality

SLASH_MULTIREPLY1 = "/r+"
SLASH_MULTIREPLY2 = "/r+ reset"
SlashCmdList["MULTIREPLY"] = function(inputMessage)
    if inputMessage == "reset" then
        alreadyWhisperedPlayersSet = {}
        print("Reset whispered players list. You can now whisper all recent players again.")
    else
        handleWhisperToLastPlayers(inputMessage)
    end
end

-- Add player to recentWhisperedPlayersList and maintain set

local function addRecentWhisperedPlayer(playerName)
    if recentWhisperedPlayersSet[playerName] then
        for i = 1, #recentWhisperedPlayersList do
            if recentWhisperedPlayersList[i] == playerName then
                table.remove(recentWhisperedPlayersList, i)
                break
            end
        end
    else
        recentWhisperedPlayersSet[playerName] = true
    end

    table.insert(recentWhisperedPlayersList, playerName)

    while #recentWhisperedPlayersList > maxRecentWhisperedPlayers do
        local removedPlayerName = table.remove(recentWhisperedPlayersList, 1)
        recentWhisperedPlayersSet[removedPlayerName] = nil
    end
end

-- Track incoming whispers to update recentWhisperedPlayersList

local whisperTrackingFrame = CreateFrame("Frame")
whisperTrackingFrame:RegisterEvent("CHAT_MSG_WHISPER")
whisperTrackingFrame:SetScript("OnEvent", function(_, _, _, senderName)
    addRecentWhisperedPlayer(senderName)
end)