# Lua Scripts

This repository contains several Lua scripts with various functionalities:

1. `gss.lua`: This script provides various screenshot functionalities. It uses the `grim` and `swappy` tools to take screenshots of different areas such as a specific region, a window, or the entire screen. It also provides a custom function to visualize aspect ratios.

2. `eclean.lua`: This script is used to clean up the system. It executes a series of commands to remove unused packages, clean the package cache, and trim the filesystem. It uses `notify-send` to provide feedback to the user about the cleanup process.

3. `notis.lua`: This script is used to send a series of notifications with different properties such as urgency, timeout, and actions. It uses the `notify-send` command to send these notifications.

4. `toggle_vpn.lua`: This script is used to toggle a Proton VPN connection. It checks the current VPN status and connects or disconnects accordingly. It also provides feedback to the user about the VPN status using `notify-send`.

5. `WBG.lua`: This script is used to manage wallpapers on your desktop. It provides functionalities to get all wallpapers from a specified directory, select a specific wallpaper, select a random wallpaper, select the next wallpaper, and select the previous wallpaper. It uses the `wbg` command to set the wallpaper and stores the current wallpaper index in a file.

6. `listPkgs.lua`: This script is used to list all explicitly installed packages on an Arch Linux system. It executes the `pacman -Qe` command to get the list of packages and their versions, and then formats this information into a markdown table. The table is then written to a file named `INSTALLEDPKGS.MD`.
