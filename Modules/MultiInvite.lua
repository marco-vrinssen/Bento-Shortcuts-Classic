-- INVITE ALL PLAYERS IN /WHO COMMAND

local function inviteWhoPlayers(msg)
    local message = msg ~= "" and msg or nil
    local numWhos = C_FriendList.GetNumWhoResults()
    local invitedCount = 0

    if numWhos and numWhos > 0 then
        for i = 1, numWhos do
            local info = C_FriendList.GetWhoInfo(i)
            if info and info.fullName then
                InviteUnit(info.fullName)
                invitedCount = invitedCount + 1

                if message then
                    SendChatMessage(message, "WHISPER", nil, info.fullName)
                end

                if invitedCount > 5 and not IsInRaid() then
                    ConvertToRaid()
                end
            end
        end
    end
end

SLASH_INVITEWHO1 = "/wi"
SlashCmdList["INVITEWHO"] = inviteWhoPlayers

-- INVITE ALL PLAYERS IN /WHO COMMAND TO GUILD

local function inviteWhoPlayersToGuild(msg)
    local message = msg ~= "" and msg or nil
    local numWhos = C_FriendList.GetNumWhoResults()

    if numWhos and numWhos > 0 then
        for i = 1, numWhos do
            local info = C_FriendList.GetWhoInfo(i)
            if info and info.fullName then
                GuildInvite(info.fullName)

                if message then
                    SendChatMessage(message, "WHISPER", nil, info.fullName)
                end
            end
        end
    end
end

SLASH_INVITEGUILDWHO1 = "/wgi"
SlashCmdList["INVITEGUILDWHO"] = inviteWhoPlayersToGuild