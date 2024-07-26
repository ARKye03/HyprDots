local Utils = require('utils')

--Terminals
Utils.Spawn({ "Super" }, "Return", "/usr/bin/alacritty")
Utils.Spawn({ "Super", "Shift" }, "Return", "/usr/bin/kitty")
Utils.Spawn({ "Super", "Control" }, "Return", "/usr/bin/warp-terminal")

--AGS
Utils.Spawn({ "Super" }, "D", '/usr/bin/ags -t applauncher')
Utils.Spawn({ "Super" }, "R", '/usr/bin/ags -q; ags')

--Browser
Utils.Spawn({ "Super" }, "W",
    '/usr/bin/brave --enable-features=UseOzonePlatform --ozone-platform=wayland --use-gl=desktop --disable-features=UseChromeOSDirectVideoDecoder --enable-features=VaapiVideoDecoder')

--Various
Utils.Spawn({ "Super" }, "V", "$HOME/.dotfiles/scripts/toggle_vpn.lua")
Utils.Spawn({ "Super" }, "X", "$HOME/.config/rofi/powermenu/type-4/powermenu.sh")
Utils.Spawn({ "Super" }, "M", "/usr/bin/alacritty --class floatcritty -e /usr/bin/ncmpcpp -c $HOME/.ncmpcpp/config")
Utils.Spawn({ "Super" }, "E", "/usr/bin/thunar")

--Screenshots
Utils.Spawn({ "Super" }, "Print", "$HOME/.dotfiles/scripts/gss.lua region")
Utils.Spawn({ "Super" }, "S", "$HOME/.dotfiles/scripts/gss.lua window")
-- Utils.Spawn({ "None " }, "r", "$HOME/.dotfiles/scripts/gss.lua full")
Utils.Spawn({ "Super" }, "Q", "$HOME/.dotfiles/scripts/gss.lua aspect_visualizer")

--Wallpaper
Utils.Spawn({ "Super" }, "U", "$HOME/.dotfiles/scripts/WBG.lua next")
Utils.Spawn({ "Super", "Shift" }, "U", "$HOME/.dotfiles/scripts/WBG.lua prev")

--HyprEcko
Utils.Spawn({ "Super" }, "P", '/usr/bin/hyprpicker -a')
Utils.Spawn({ "Super" }, "L", '/usr/bin/hyprlock')

--Workflow
Utils.Action({ "Super" }, "C", "close")
Utils.Action({ "Super", "Shift" }, "E", "exit")
Utils.Action({ "Super" }, "Tab", "focus-previous-tags")
Utils.Action({ "Super" }, "Space", "toggle-float")
Utils.Action({ "Super" }, "F", "toggle-fullscreen")

-- Tags management
for i = 1, 9 do
    local tag = i

    -- Super+[1-9] to focus tag [0-8]
    Utils.SetFocusedTag({ "Super" }, tostring(i), tag)

    -- Super+Shift+[1-9] to tag focused view with tag [0-8]
    Utils.SetViewTag({ "Super", "Shift" }, tostring(i), tag)

    -- Super+Control+[1-9] to toggle focus of tag [0-8]
    Utils.ToggleFocusedTag({ "Super", "Control" }, tostring(i), tag)

    -- Super+Shift+Control+[1-9] to toggle tag [0-8] of focused view
    Utils.ToggleViewTag({ "Super", "Shift", "Control" }, tostring(i), tag)
end
