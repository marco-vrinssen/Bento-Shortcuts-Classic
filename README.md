# Bento Shortcuts Classic

Addon for World of Warcraft Classic providing efficiency-enhancing shortcuts and automation.

## Core Features

### Command Overview

- `/bentoshortcuts` : Display all available commands

### Chat & Messaging

- `/scan <KEYWORD>` : Monitor chat for keyword
- `/scan stop` : Stop scanning
- `/scan clear` : Clear scan results
- `/w+ [MESSAGE]` : Whisper all players in /who list
  - `/w+ N [MESSAGE]` : Whisper first N players
  - `/w+ -CLASS [MESSAGE]` : Exclude class
- `/w+- [MESSAGE]` : Whisper with ignore list (persistent)
- `/clearplayerlist` : Clear whisper ignore list
- `/r+ [MESSAGE]` : Reply to recent whisper senders
  - `/r+ N [MESSAGE]` : Reply to last N senders
- `/ws [MESSAGE]` : Whisper all auction sellers
- `/lfg [MESSAGE]` : Broadcast to World/LFG channels

### Gear Manager

- `/gearset [NAME]` : Save current gear as named set
- `/equipset [NAME]` : Equip named gear set
- Gear sets stored in dedicated subtables for organization

### Player Targeting

- `/find [NAME]` : Set find macro to name
- `/find` : Set find macro to current target
- `/find+ [NAME]` : Add name to find macro
- `/find+` : Add current target to find macro

### Travel & Portal Shortcuts

- `/travel [ZONE]` : Find warlocks for summons
- `/travel` : Find mages for portals in zone

### Group & Raid Utility

- `/rc` : Ready check
- `/q` : Leave party/raid

### System & UI Commands

- `/errors` : Toggle LUA error display
- `/ui` : Reload interface
- `/gx` : Restart graphics engine
- `/rl` : Reload UI, restart graphics, clear cache

### Sound Management

- `/mutesound <ID>` : Mute sound by ID
- `/mutesound clear` : Unmute all sounds
- `/mutesound check` : List muted sounds
- `/mutesound default` : Restore default muted sounds
- Muted sounds stored in dedicated subtable

### Automation & Quality of Life

- Fast looting: auto-loot items
- Auto-sell junk: sell gray items at vendor
- Auto-repair: repair gear at vendor
- Auto-confirm dialogs: accept common prompts
- Copy name: Ctrl+I (Cmd+I on Mac) to copy unit/item name
- UI reload: right-click main menu button

### Classic Armory

- Generate Classic Armory link via context menu

---

For full usage, type `/bentoshortcuts` in-game.