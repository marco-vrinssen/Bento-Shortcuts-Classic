-- COMMAND INTRO MESSAGE

local function commandsIntro()
    print(YELLOW_CHAT_LUA .. "/bentocmd" .. "|r" .. " for available commands.")
end

local function showCommandList()
    print(YELLOW_CHAT_LUA .. "/bentocmd" .. "|r" .. ": " .. "|r" .. "Displays the list of available commands." .. "|r")

    print(YELLOW_CHAT_LUA .. "/f KEYWORD" .. "|r" .. ": " .. "|r" .. "Filters all active channels for KEYWORD and reposts matching messages." .. "|r")
    print(YELLOW_CHAT_LUA .. "/f KEYWORD1+KEYWORD2" .. "|r" .. ": " .. "|r" .. "Filters all active channels for the combination of KEYWORD1 and KEYWORD2 and reposts matching messages." .. "|r")
    print(YELLOW_CHAT_LUA .. "/f" .. "|r" .. ": " .. "|r" .. "Clears and stops the filtering." .. "|r")
    
    print(YELLOW_CHAT_LUA .. "/ww MESSAGE" .. "|r" .. ": " .. "|r" .. "Sends the MESSAGE to all players in a currently open /who instance." .. "|r")
    print(YELLOW_CHAT_LUA .. "/ww N MESSAGE" .. "|r" .. ": " .. "|r" .. "Sends the MESSAGE to the first N count of players in a currently open /who instance." .. "|r")
    print(YELLOW_CHAT_LUA .. "/ww -CLASS MESSAGE" .. "|r" .. ": " .. "|r" .. "Sends the MESSAGE to all players who are not of the specified CLASS in a currently open /who instance." .. "|r")
    print(YELLOW_CHAT_LUA .. "/ww N -CLASS MESSAGE" .. "|r" .. ": " .. "|r" .. "Sends the MESSAGE to the first N count of players who are not of the specified CLASS in a currently open /who instance." .. "|r")
    print(YELLOW_CHAT_LUA .. "/wl N MESSAGE" .. "|r" .. ": " .. "|r" .. "Sends the MESSAGE to the last N players who whispered you." .. "|r")
    
    print(YELLOW_CHAT_LUA .. "/wah MESSAGE" .. "|r" .. ": " .. "|r" .. "Sends the MESSAGE to all unique sellers in current auction house search results." .. "|r")
    print(YELLOW_CHAT_LUA .. "/wah N MESSAGE" .. "|r" .. ": " .. "|r" .. "Sends the MESSAGE to the first N unique sellers in current auction house search results." .. "|r")
    
    print(YELLOW_CHAT_LUA .. "/c" .. "|r" .. ": " .. "|r" .. "Closes all whisper tabs." .. "|r")
    
    print(YELLOW_CHAT_LUA .. "/fm TARGET" .. "|r" .. ": " .. "|r" .. "Creates or updates a macro to target the specified TARGET." .. "|r")
    print(YELLOW_CHAT_LUA .. "/fm+" .. "|r" .. ": " .. "|r" .. "Adds the current target or specified TARGET to the existing target macro." .. "|r")
    print(YELLOW_CHAT_LUA .. "/am" .. "|r" .. ": " .. "|r" .. "Creates or updates a macro to assist the specified TARGET." .. "|r")
    
    print(YELLOW_CHAT_LUA .. "/rc" .. "|r" .. ": " .. "|r" .. "Performs a ready check." .. "|r")
    print(YELLOW_CHAT_LUA .. "/q" .. "|r" .. ": " .. "|r" .. "Leaves the current party or raid." .. "|r")
    print(YELLOW_CHAT_LUA .. "/wi" .. "|r" .. ": " .. "|r" .. "Invites all players in the /who list to the party." .. "|r")
    print(YELLOW_CHAT_LUA .. "/wgi" .. "|r" .. ": " .. "|r" .. "Invites all players in /who to the guild." .. "|r")
    
    print(YELLOW_CHAT_LUA .. "/ui" .. "|r" .. ": " .. "|r" .. "Reloads the user interface." .. "|r")
    print(YELLOW_CHAT_LUA .. "/gx" .. "|r" .. ": " .. "|r" .. "Restarts the graphics engine." .. "|r")
    print(YELLOW_CHAT_LUA .. "/errors" .. "|r" .. ": " .. "|r" .. "Toggles the display of LUA errors." .. "|r")
    print(YELLOW_CHAT_LUA .. "/rl" .. "|r" .. ": " .. "|r" .. "Reloads the UI, restarts the graphics engine, and clears the game cache." .. "|r")
end

local introEvents = CreateFrame("Frame")
introEvents:RegisterEvent("PLAYER_LOGIN")
introEvents:SetScript("OnEvent", commandsIntro)

SLASH_BENTOCMD1 = "/bentocmd"
SlashCmdList["BENTOCMD"] = function(msg, editBox)
    if msg == "" then
        showCommandList()
    end
end