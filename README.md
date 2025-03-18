# Bento Plus Classic

## Addon for World of Warcraft Classic with chat commands enhancing communication, featuring chat filtering and multi-communication functionalities.

### **Filtering and Communication**
- **`/bentocmd`** – Displays the list of available commands.
- **`/f KEYWORD`** – Filters all active channels for `KEYWORD` and reposts matching messages.
- **`/f KEYWORD1+KEYWORD2`** – Filters messages containing both `KEYWORD1` and `KEYWORD2`.
- **`/f`** – Clears and stops the filtering.
- **`/ww MESSAGE`** – Sends `MESSAGE` to all players in a currently open `/who` instance.
- **`/ww N MESSAGE`** – Sends `MESSAGE` to the first `N` players in `/who`.
- **`/ww -CLASS MESSAGE`** – Sends `MESSAGE` to all players except `CLASS` in `/who`.
- **`/ww N -CLASS MESSAGE`** – Sends `MESSAGE` to the first `N` players except `CLASS` in `/who`.
- **`/wl N MESSAGE`** – Sends `MESSAGE` to the last `N` players who whispered you.
- **`/wah MESSAGE`** – Sends `MESSAGE` to all unique sellers in the auction house search results.
- **`/wah N MESSAGE`** – Sends `MESSAGE` to the first `N` unique sellers in the auction house search results.
- **`/c`** – Closes all whisper tabs.
- **`/fm TARGET`** – Creates or updates a macro to target `TARGET` and sets a raid marker if the target exists.
- **`/fm+ TARGET`** – Adds `TARGET` to the existing macro, allowing up to 3 targets.
- **`/am TARGET`** – Creates or updates a macro to assist `TARGET`.

### **Group and Raid Management**
- **`/rc`** – Performs a ready check.
- **`/q`** – Leaves the current party or raid.
- **`/wi`** – Invites all players in the `/who` list to the party.
- **`/wgi`** – Invites all players in `/who` to the guild.

### **UI and System Management**
- **`/ui`** – Reloads the user interface.
- **`/gx`** – Restarts the graphics engine.
- **`/lua`** – Toggles the display of LUA errors.
- **`/rl`** – Reloads the UI, restarts the graphics engine, and clears the game cache.
- **Right-click on the game menu button** – Reloads the UI.

### **Quality of Life Improvements**
- **Auto-confirm or auto-close confirmation modals.**
- **Optimize graphics settings for a cleaner and smoother experience.**
- **Mute specific annoying sounds** (e.g., mechastrider loop, bow pull sound).
- **Enable instant auto-looting.**
- **Automatically sell grey items when visiting a merchant and repair gear if possible.**
- **Fix mail display issues when opening the mailbox.**