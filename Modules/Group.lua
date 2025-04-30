-- READY CHECK COMMAND

local function readyCheck()
    DoReadyCheck()
end

SLASH_READYCHECK1 = "/rc"
SlashCmdList["READYCHECK"] = readyCheck

-- ROLE CHECK COMMAND

local function roleCheck()
    InitiateRolePoll()
end

SLASH_ROLECHECK1 = "/rc+"
SlashCmdList["ROLECHECK"] = roleCheck

-- QUIT GROUP COMMAND

local function quitParty() 
    if IsInGroup() then 
        LeaveParty() 
    end 
end

SLASH_QUITPARTY1 = "/q"
SlashCmdList["QUITPARTY"] = quitParty

-- MARK PARTY MEMBERS BY ROLE

local function markParty()
    if not IsInGroup() then
        print("You are not in a group.")
        return
    end

    for partyIndex = 1, GetNumGroupMembers() do
        local unitId = "party" .. partyIndex
        if UnitExists(unitId) then
            local assignedRole = UnitGroupRolesAssigned(unitId)
            if assignedRole == "TANK" then
                SetRaidTarget(unitId, 6)
            elseif assignedRole == "HEALER" then
                SetRaidTarget(unitId, 1)
            end
        end
    end
end

SLASH_MARKPARTY1 = "/mp"
SlashCmdList["MARKPARTY"] = markParty