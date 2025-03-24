# Bento Commands Classic

Addon for World of Warcraft Classic with chat commands enhancing communication, featuring chat filtering and multi-communication functionalities.

Type `/bentocmd` for available commands.

### Chat Filtering
`/f KEYWORD` - Filter all active channels for KEYWORD and repost matching messages.
`/f KEYWORD1+KEYWORD2` - Filter all active channels for the combination of KEYWORD1 and KEYWORD2 and repost matching messages.
`/f` - Clear and stop the filtering.

### Multi Whisper
`/ww MESSAGE` - Send MESSAGE to all players in a currently open /who instance.
`/ww N MESSAGE` - Send MESSAGE to the first N players in a currently open /who instance.
`/ww -CLASS MESSAGE` - Send MESSAGE to all players except those of CLASS in a currently open /who instance.
`/ww N -CLASS MESSAGE` - Send MESSAGE to the first N players except those of CLASS in a currently open /who instance.

### Whisper Invite
`/wi` - Send MESSAGE and invite all players in the currently open /who list.
`/wgi` - Send MESSAGE and guild invite all players in the currently open /who list.

### Whisper Last
`/wl MESSAGE` - Send MESSAGE to all players who whispered you.
`/wl N MESSAGE` - Send MESSAGE to the last N players who whispered you.

### Whisper Sellers
`/wah MESSAGE` - Send MESSAGE to all unique sellers in current auction house search results.
`/wah N MESSAGE` - Send MESSAGE to the first N unique sellers in current auction house search results.

### Find Mages and Warlocks
`/port ZONE` - Search for warlocks in ZONE who can summon.
`/port` - Search for mages in the current zone who can provide portals.

### Close Whisper Tabs
`/c` - Close all whisper tabs.

### Target Macros
`/fm TARGET` - Create or update a macro to target TARGET. If no TARGET is specified, the current target is used.
`/fm NAME` - Create or update a macro to target NAME. If no NAME is specified, the current target is used.
`/fm+ TARGET` - Add the current target or specified TARGET to the existing target macro. Up to 3 targets can be added.
`/fm+ NAME` - Add the current target or specified NAME to the existing target macro. Up to 3 targets can be added.
`/am TARGET` - Create or update a macro to assist TARGET. If no TARGET is specified, the current target is used.
`/am NAME` - Create or update a macro to assist NAME. If no NAME is specified, the current target is used.

### Group Utility
`/rc` - Perform a ready check.
`/q` - Leave the current party or raid.

### Game Utility
`/ui` - Reload the user interface.
`/gx` - Restart the graphics engine.
`/le` - Toggle the display of LUA errors.
`/rl` - Reload the UI, restart the graphics engine, and clear the game cache.