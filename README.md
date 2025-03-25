# Bento Shortcuts Classic

Addon for World of Warcraft Classic enhancing communication with chat commands, macro utilities, and group/game functions.

**Usage:** Type `/bentoshortcuts` for a command overview.

## Chat Commands

- **Keyword Scan:**  
  `/scan <KEYWORD>` – Scan all chat channels for messages containing KEYWORD.  
  
  `/scan stop` or `/scan clear` – Stop scanning.

- **Multi Whisper:**  
  `/w+ MESSAGE` – Whisper MESSAGE to all players in the current /who list.  
  
  `/w+ N MESSAGE` – Whisper MESSAGE to the first N players in the /who list.  
  
  `/w+ -CLASS MESSAGE` – Whisper MESSAGE to players excluding a specific CLASS.  
  
  `/w+ N -CLASS MESSAGE` – Whisper MESSAGE to the first N players excluding CLASS.

- **Whisper Reply:**  
  `/r+ MESSAGE` – Whisper MESSAGE to all players who last whispered you.  
  
  `/r+ N MESSAGE` – Whisper MESSAGE to the last N players who whispered you.

## Macro Commands

- **Target Macro (Find):**  
  `/find [TARGET]` – Create or update a macro to target a specified player or your current target if omitted.
  
- **Add to Target Macro:**  
  `/find+ [TARGET]` – Add a target to the existing macro (up to 3 entries).

## Travel Command

- **Travel Search:**  
  `/travel ZONE` – Search for warlocks in ZONE who can summon.  
  
  `/travel` – Search for mages in the current zone who can provide portals.

## LFG Command

- **LFG Broadcast:**  
  `/lfg MESSAGE` – Broadcast MESSAGE across LFG channels ("World" and "LookingForGroup").

## Group & Game Utility

- **Group Utility:**  
  `/rc` – Perform a ready check.  
  
  `/q` – Leave the current party or raid.

- **Game Utility:**  
  `/errors` – Toggle LUA error display.  
  
  `/ui` – Reload the user interface.  
  
  `/gx` – Restart the graphics engine.  
  
  `/rl` – Reload the UI, restart the graphics engine, and clear the game cache.

## Additional Features

- **Copy Name Popup:**  
  Press Control + I (or Command + I on Mac) while hovering over an item or unit to show its name.

- **Right-Click Menus:**  
  Access targeting and player link options by right-clicking on player frames or names.