# Bento Shortcuts Classic

Addon for World of Warcraft Classic. Offers chat scanning, whisper utilities, macros, and game functions.

**Usage:** `/bentoshortcuts`

## Chat Commands

### KEYWORD SCAN

```
/scan <KEYWORD>
```

Scans chat channels for messages containing KEYWORD. Stop scanning with `/scan stop` or `/scan clear`.

### MULTI WHISPER

```
/w+ MESSAGE
/w+ N MESSAGE
/w+ -CLASS MESSAGE
/w+ N -CLASS MESSAGE
```

Whispers MESSAGE to players in the current /who list. Supports targeting the first N players or excluding a specific class.

### WHISPER REPLY

```
/r+ MESSAGE
/r+ N MESSAGE
```

Replies to the player(s) who last whispered you.

## Macro Commands

### TARGET MACRO

```
/find [TARGET]
```

Creates or updates a macro to target the specified player or the current target if omitted.

### ADD TARGET

```
/find+ [TARGET]
```

Adds a player to the target macro (up to 3 targets).

## Travel Command

```
/travel [ZONE]
```

Searches for summoner warlocks in ZONE, or mages in the current zone if omitted.

## LFG Command

```
/lfg MESSAGE
```

Broadcasts MESSAGE on World and LookingForGroup channels.

## Group & Game Utility

### GROUP UTILITIES

```
/rc
/q
```

Performs a ready check or leaves the party/raid.

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

### RIGHT-CLICK MENU

Access targeting and link options by right-clicking on player frames or names.

## Context Menu Options

### ASSIST

```
/assist
```

Assists the target via the context menu.

### FIND

```
/find [TARGET]
```

Updates the target macro for the specified player or current target.

### FIND ALSO

```
/find+ [TARGET]
```

Adds an extra target to the macro (up to 3 targets).

### ARMORY LINK

```
/armory
```

Generates a link to the Classic Armory.