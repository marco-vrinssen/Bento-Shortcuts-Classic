-- Initialize searchExpression for boolean search functionality

local searchExpression = {}

-- Initialize chatScanFrame for event handling

local chatScanFrame = CreateFrame("Frame")

-- Define notifyKeywordMatch to alert on keyword match

local function notifyKeywordMatch(matchedMsg, matchedSender)
    local senderLink = "|Hplayer:" .. matchedSender .. "|h" .. YELLOW_LIGHT_LUA .. "[" .. matchedSender .. "]:|r|h"
    print(senderLink .. " " .. matchedMsg)
    PlaySound(3175, "Master", true)
end

-- Define evaluateSearchExpression to check message against boolean criteria

local function evaluateSearchExpression(chatMsg)
    local messageText = strlower(chatMsg)
    
    local function containsKeyword(keyword)
        return strfind(messageText, strlower(keyword), 1, true)
    end
    
    if not searchExpression.operator then
        return containsKeyword(searchExpression.operands[1])
    elseif searchExpression.operator == "AND" then
        return containsKeyword(searchExpression.operands[1]) and containsKeyword(searchExpression.operands[2])
    elseif searchExpression.operator == "OR" then
        return containsKeyword(searchExpression.operands[1]) or containsKeyword(searchExpression.operands[2])
    elseif searchExpression.operator == "NOT" then
        if #searchExpression.operands == 2 then
            return containsKeyword(searchExpression.operands[1]) and not containsKeyword(searchExpression.operands[2])
        else
            return not containsKeyword(searchExpression.operands[1])
        end
    end
    
    return false
end

-- Define handleChatMsgEvent to process chat messages

local function handleChatMsgEvent(_, _, chatMsg, senderName, _, channelName, ...)
    if searchExpression.operands and #searchExpression.operands > 0 and strmatch(channelName, "%d+") then
        local channelNum = tonumber(strmatch(channelName, "%d+"))
        if channelNum and channelNum >= 1 and channelNum <= 20 and evaluateSearchExpression(chatMsg) then
            notifyKeywordMatch(chatMsg, senderName)
        end
    end
end

chatScanFrame:SetScript("OnEvent", handleChatMsgEvent)

-- Define parseBooleanExpression to parse boolean search input

local function parseBooleanExpression(inputCmd)
    local tokens = {}
    for token in string.gmatch(inputCmd, "%S+") do 
        tokens[#tokens + 1] = token 
    end
    
    if #tokens == 0 then
        return { operator = nil, operands = {} }
    elseif #tokens == 1 then
        return { operator = nil, operands = { tokens[1] } }
    end
    
    -- Handle complex expressions like "x OR y NOT z"
    local operands = {}
    local mainOperator = nil
    local i = 1
    
    while i <= #tokens do
        local token = string.upper(tokens[i])
        if token == "AND" or token == "OR" or token == "NOT" then
            if not mainOperator then
                mainOperator = token
            end
            i = i + 1
        else
            operands[#operands + 1] = tokens[i]
            i = i + 1
        end
    end
    
    return { operator = mainOperator, operands = operands }
end

-- Define handleScanCommand to manage scan command input

local function handleScanCommand(cmdInput)
    local trimmedCmd = cmdInput:match("^%s*(.-)%s*$")
    
    if trimmedCmd == "" then
        searchExpression = {}
        chatScanFrame:UnregisterEvent("CHAT_MSG_CHANNEL")
        print(YELLOW_LIGHT_LUA .. "[Chat Scan]:|r Disabled.")
    else
        searchExpression = parseBooleanExpression(trimmedCmd)
        if not chatScanFrame:IsEventRegistered("CHAT_MSG_CHANNEL") then
            chatScanFrame:RegisterEvent("CHAT_MSG_CHANNEL")
        end
        print(YELLOW_LIGHT_LUA .. "[Chat Scan]:|r " .. trimmedCmd)
    end
end

-- Register /scan slash command for chat scanning

SLASH_SCAN1 = "/scan"
SlashCmdList["SCAN"] = handleScanCommand