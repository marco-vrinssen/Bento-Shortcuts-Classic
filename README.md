# Bento Shortcuts Classic

Addon for World of Warcraft Classic. Offers chat scanning, whisper utilities, macros, and game functions.

**Usage:** `/bentoshortcuts`

## Chat Commands

### KEYWORD SCAN  
```
/scan <KEYWORD>
```
Scans chat channels for messages containing KEYWORD. Use `/scan stop` or `/scan clear` to end scanning.

### MULTI WHISPER  
```
/w+ MESSAGE
/w+ N MESSAGE
/w+ -CLASS MESSAGE
/w+ N -CLASS MESSAGE
```
Sends a whisper to players in the current /who list. Supports limiting to the first N players or excluding a specified class.

### WHISPER REPLY  
```
/r+ MESSAGE
/r+ N MESSAGE
```
Replies to the last whisper sender(s).

## Macro Commands

### TARGET MACRO  
```
/find [TARGET]
```
Creates or updates a target macro using the given player name, or your current target if omitted.

### ADD TARGET  
```
/find+ [TARGET]
```
Adds an additional target to the macro (max 3 targets).

## Travel Command

### TRAVEL SEARCH  
```
/travel [ZONE]
```
Searches for summoner warlocks in the specified ZONE, or mages in your current zone if omitted.

## LFG Command

### LFG BROADCAST  
```
/lfg MESSAGE
```
Broadcasts a message on both World and LookingForGroup channels.

## Group Utility

### READY CHECK  
```
/rc
```
Performs a ready check.

### QUIT PARTY/RAID  
```
/q
```
Leaves your current party/raid.

## Game Utility

### GAME UTILITIES  
```
/errors
/ui
/gx
/rl
```
Toggles LUA error display, reloads the UI, restarts graphics, and clears the game cache.

## Additional Features

### COPY NAME  
Press Control + I (or Command + I on Mac) when hovering over an item or unit to copy its name.

### UI RELOAD SHORTCUT
Right-click the main menu button to quickly reload your UI.

## Right-Click Menu Options

### ASSIST  
```
Assist
```
Assists the selected target via the right-click menu.

### FIND  
```
Find
```
Activates the target macro for the chosen player via the right-click menu.

### FIND ALSO  
```
Find Also
Adds an extra target to the macro (max 3) using the right-click menu.

### ARMORY LINK  
```
Classic Armory
```
Generates a link to the Classic Armory for the selected player.