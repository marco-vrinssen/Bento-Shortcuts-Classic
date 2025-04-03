local function layerCommand()
    local maxLevel = GetMaxPlayerLevel()
    local randomMinLevel = math.random(5, maxLevel - 1)
    local randomMaxLevel = math.random(randomMinLevel + 1, maxLevel)
    local message = "Hey, could you please invite me for a layer switch, thank you! :)"

    C_FriendList.SendWho(randomMinLevel .. "-" .. randomMaxLevel)

    C_Timer.After(1, function()
        local numWhos = C_FriendList.GetNumWhoResults()
        if numWhos and numWhos > 0 then
            local selectedIndices = {}
            while #selectedIndices < math.min(5, numWhos) do
                local randomIndex = math.random(1, numWhos)
                if not selectedIndices[randomIndex] then
                    selectedIndices[randomIndex] = true
                end
            end

            for index in pairs(selectedIndices) do
                local info = C_FriendList.GetWhoInfo(index)
                if info and info.fullName then
                    SendChatMessage(message, "WHISPER", nil, info.fullName)
                end
            end
        end
    end)
end

SLASH_LAYER1 = "/layer"
SlashCmdList["LAYER"] = layerCommand