# Bento Shortcuts Classic

Utility addon for World of Warcraft Classic providing targeting, communication, travel, and interface shortcuts.

**Settings:** `/bentoshortcuts`

## Chat Commands

### Keyword Scanning
- `/scan <KEYWORD>` - Monitor chat channels for messages containing keyword
- `/scan stop` - End scanning
- `/scan clear` - End scanning

### Multi Messaging
- `/w+ [MESSAGE]` - Whisper to all players in current /who list
  - `/w+ N [MESSAGE]` - Whisper first N players only
  - `/w+ -CLASS [MESSAGE]` - Exclude players of specified class
- `/r+ [MESSAGE]` - Reply to recent whisper senders
  - `/r+ N [MESSAGE]` - Reply to last N whisper senders
- `/lfg [MESSAGE]` - Broadcast to World and LookingForGroup channels

### Player Targeting
- `/find [NAME]` - Set find macro to specified name
- `/find` - Set find macro to current target's name
- `/find+ [NAME]` - Add specified name to find macro
- `/find+` - Add current target to find macro

### Travel Shortcuts
- `/travel [ZONE]` - Find warlocks offering summons to specified zone
- `/travel` - Find mages offering portals in current zone

### Group Utility
- `/rc` - Perform ready check
- `/q` - Leave current party/raid

## UI Shortcuts

### System Commands
- `/errors` - Toggle LUA error display
- `/ui` - Reload interface
- `/gx` - Restart graphics engine
- `/rl` - Reload UI, restart graphics, clear cache

### Quick Actions
- **UI Reload:** Right-click main menu button
- **Classic Armory:** Access via right-click menu on players
- **Copy Name:** Press Control+I (Command+I on Mac) when hovering over item/unit