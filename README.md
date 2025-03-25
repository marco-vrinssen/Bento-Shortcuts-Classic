# Bento Shortcuts Classic

Addon for World of Warcraft Classic. Offers chat scanning, whisper utilities, macros, and game functions.

**Usage:** `/bentoshortcuts`

## Chat Commands

### KEYWORD SCAN  
**Command:**  
```
/scan <KEYWORD>
```

**Explanation:**  
Scans chat channels for messages containing KEYWORD. Use `/scan stop` or `/scan clear` to end scanning.

### MULTI WHISPER  
**Command:**  
```
/w+ MESSAGE
/w+ N MESSAGE
/w+ -CLASS MESSAGE
/w+ N -CLASS MESSAGE
```

**Explanation:**  
Sends a whisper to players in the current /who list. Supports limiting to the first N players or excluding a specified class.

### WHISPER REPLY  
**Command:**  
```
/r+ MESSAGE
/r+ N MESSAGE
```

**Explanation:**  
Replies to the last whisper sender(s).

## Macro Commands

### TARGET MACRO  
**Command:**  
```
/find [TARGET]
```

**Explanation:**  
Creates or updates a target macro using the given player name, or your current target if omitted.

### ADD TARGET  
**Command:**  
```
/find+ [TARGET]
```

**Explanation:**  
Adds an additional target to the macro (max 3 targets).

## Travel Command

### TRAVEL SEARCH  
**Command:**  
```
/travel [ZONE]
```

**Explanation:**  
Searches for summoner warlocks in the specified ZONE, or mages in your current zone if omitted.

## LFG Command

### LFG BROADCAST  
**Command:**  
```
/lfg MESSAGE
```

**Explanation:**  
Broadcasts a message on both World and LookingForGroup channels.

## Group & Game Utility

### GROUP UTILITIES  
**Commands:**  
```
/rc
/q
```

**Explanation:**  
Performs a ready check or leaves your current party/raid.

### GAME UTILITIES  
**Commands:**  
```
/errors
/ui
/gx
/rl
```

**Explanation:**  
Toggles LUA error display, reloads the UI, restarts graphics, and clears the game cache.

## Additional Features

### COPY NAME  
**Action:**  
Press Control + I (or Command + I on Mac)

**Explanation:**  
Copies the name of an item or unit you are hovering over.

## Right-Click Menu Options

### ASSIST  
**Command:**  
```
/assist
```

**Explanation:**  
Assists the selected target via the right-click menu.

### FIND  
**Command:**  
```
/find [TARGET]
```

**Explanation:**  
Activates the target macro for the chosen player via the right-click menu.

### FIND ALSO  
**Command:**  
```
/find+ [TARGET]
```

**Explanation:**  
Adds an extra target to the macro (max 3) using the right-click menu.

### ARMORY LINK  
**Command:**  
```
/armory
```

**Explanation:**  
Generates a link to the Classic Armory for the selected player.