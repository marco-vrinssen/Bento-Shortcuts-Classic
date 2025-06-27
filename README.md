# Bento Shortcuts Classic

World of Warcraft Classic addon providing efficiency shortcuts and automation for enhanced gameplay.

Type `/bentoshortcuts` in-game to see all commands.

## Chat & Communication

- `/cs KEYWORD` : Monitor chat channels for keyword
- `/cs stop` : Stop keyword scanning  
- `/cs clear` : Clear keyword scanning
- `/ww MESSAGE` : Whisper all players in /who list
- `/ww N MESSAGE` : Whisper first N players only
- `/ww -CLASS MESSAGE` : Exclude specific class from whispers
- `/ww+ MESSAGE` : Whisper with persistent ignore list
- `/clearskiplist` : Clear whisper ignore list
- `/rr MESSAGE` : Reply to recent whisper senders
- `/rr N MESSAGE` : Reply to last N whisper senders
- `/rr reset` : Reset whispered players list
- `/wt MESSAGE` : Whisper current target
- `/wt+ MESSAGE` : Whisper target with ignore tracking
- `/lfg MESSAGE` : Broadcast to World and LookingForGroup channels

## Gear Management

- `/gearset NAME` : Save current gear as named set
- `/equipset NAME` : Equip saved gear set
- Gear sets are stored persistently across sessions

## Player Targeting

- `/find NAME` : Create find macro for specific player
- `/find` : Create find macro for current target
- `/find+ NAME` : Add player to existing find macro
- `/find+` : Add current target to find macro
- `/alsofind NAME` : Alternative command to add to find macro
- `/assist NAME` : Create assist macro for target
- Generates targeting macros with Classic Armory links

## Travel & Portals

- `/port ZONE` : Find warlocks for summons to zone
- `/port` : Find mages for portals in current zone

## Group Management

- `/rc` : Initiate ready check
- `/rc+` : Initiate role check
- `/q` : Leave party/raid
- `/mp` : Mark party members by role

## System & Interface

- `/errors` : Toggle Lua error display
- `/ui` : Reload user interface
- `/gx` : Restart graphics engine
- `/rl` : Full reload with UI, graphics, and cache clear
- Right-click Main Menu button for quick UI reload

## Sound Management

- `/mutesound ID` : Mute specific sound by ID
- `/mutesound clear` : Unmute all sounds
- `/mutesound check` : List currently muted sounds
- `/mutesound default` : Restore default muted sounds
- Includes preset mutes for common annoying sounds

## Tracking Automation

- `/ts` : Toggle herb/mineral tracking switcher
- Automatically alternates between Find Herbs and Find Minerals

## Automatic Features

### Merchant Automation
- Auto-sell junk items when visiting vendors
- Auto-repair damaged gear at vendors

### Loot Automation  
- Fast loot for quicker item collection
- Auto-confirm loot roll and bind confirmations

### Quality of Life
- Copy names with Ctrl+I (Mac: Cmd+I) for hovered items/units
- Context menus with Classic Armory links and targeting options

All settings and saved data persist between sessions.