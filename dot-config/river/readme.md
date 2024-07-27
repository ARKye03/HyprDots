# River Config

---

## Overview

This script initializes and configures various components for a Lua-based application. It imports several modules and executes their main functions to set up key bindings, view rules, properties, and tiling configurations.

## Script Breakdown

- **Autostart**: This module is responsible for running any necessary startup routines. (Currently commented out)

- **KeyBinds**: This module sets up the key bindings for the application.

- **ViewRules**: This module defines the rules for how views (windows) should be managed.

- **Props**: This module configures various properties for the application.

- **Rivertile**: This module sets up the tiling window manager.

### Utilities script

#### utils.lua

This Lua script provides a set of utility functions to interact with the riverctl command, which is used to configure the River window manager. The script defines several functions to map key bindings, set properties, and manage view rules.

#### Functions

- Mapping.Spawn(modkeys, keybind, command)

  - Maps a key combination to spawn a new process.
  - modkeys: List of modifier keys (e.g., {"Mod4", "Shift"}).
  - keybind: The key to bind (e.g., "Return").
  - command: The command to execute (e.g., "alacritty").

- Mapping.Action(modkeys, keybind, option)

  - Maps a key combination to a specific action.
  - modkeys: List of modifier keys.
  - keybind: The key to bind.
  - option: The action to perform (e.g., "close").

- Mapping.Pointer(modkeys, keybind, option)

  - Maps a key combination to a pointer action.
  - modkeys: List of modifier keys.
  - keybind: The key to bind.
  - option: The pointer action to perform.

- Mapping.Property(property, value)

  - Sets a property for the River window manager.
  - property: The property to set (e.g., "border-width").
  - value: The value to set for the property.

- Mapping.ViewRule(id, tag)

  - Adds a rule to assign a specific tag to a window based on its application ID.
  - id: The application ID.
  - tag: The tag to assign.

- Mapping.ViewSSD(id)

  - Adds a rule to enable server-side decorations (SSD) for a window based on its application ID.
  - id: The application ID.

- Mapping.SetFocusedTag(modkeys, keybind, tag)

  - Maps a key combination to set the focused tag.
  - modkeys: List of modifier keys.
  - keybind: The key to bind.
  - tag: The tag to set as focused.

- Mapping.SetViewTag(modkeys, keybind, tag)

  - Maps a key combination to set the view tag.
  - modkeys: List of modifier keys.
  - keybind: The key to bind.
  - tag: The tag to set for the view.

- Mapping.ToggleFocusedTag(modkeys, keybind, tag)

  - Maps a key combination to toggle the focused tag.
  - modkeys: List of modifier keys.
  - keybind: The key to bind.
  - tag: The tag to toggle.

- Mapping.ToggleViewTag(modkeys, keybind, tag)

  - Maps a key combination to toggle the view tag.
  - modkeys: List of modifier keys.
  - keybind: The key to bind.
  - tag: The tag to toggle.

### Tags

The script defines a table tags that maps numbers to their corresponding bitmask values, which are used to represent tags in the River window manager. For example, tag 1 is represented by 1, tag 2 by 2, and so on up to tag 9 which is represented by 256.

## Usage

To run the script, ensure you have Lua installed and execute the script with the following command:

```sh
./init.lua
```

Make sure all required modules (autostart, binds, viewrules, props, rivertile) are available in your Lua environment.
