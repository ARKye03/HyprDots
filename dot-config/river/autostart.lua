local execp = require('posix.unistd').execp
local AutoStart = {}

local apps = {
    "$HOME/.dotfiles/scripts/WBG.lua random",
    "/usr/bin/dbus-update-activation-environment --all",
    "/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh",
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
    "/usr/bin/nm-applet",
    "/usr/bin/copyq --start-server",
    "/usr/bin/hypridle",
    "/usr/bin/wl-clip-persist --clipboard regular",
    "/usr/bin/mpd-mpris --no-instance --host 127.0.0.1",
    "/usr/bin/ags",
}


local function execOnce(cmd)
    if not execp(cmd) then
        print('Failed to execute ' .. cmd)
    end
end

function AutoStart.Start()
    for _, cmd in ipairs(apps) do
        execOnce(cmd)
    end
end

return AutoStart
