local execp = require('posix.unistd').execp
local fork = require('posix.unistd').fork
local wait = require('posix.sys.wait').wait

local apps = {
    os.getenv("HOME") .. "/.dotfiles/scripts/WBG.lua random",
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

local function splitCommand(cmd)
    local t = {}
    for str in string.gmatch(cmd, "([^%s]+)") do
        table.insert(t, str)
    end
    return t
end

local function execOnce(cmd)
    local cmdTable = splitCommand(cmd)
    local pid = fork()
    if pid == 0 then
        -- Child process
        if not execp(cmdTable[1], cmdTable) then
            print('Failed to execute ' .. cmd)
        end
        os.exit() -- Ensure the child process exits after executing the command
    elseif pid > 0 then
        -- Parent process continues to the next command
    else
        print('Failed to fork for ' .. cmd)
    end
end

function Start()
    for _, cmd in ipairs(apps) do
        execOnce(cmd)
    end
    -- Optionally wait for all child processes to finish
    while true do
        local pid, status = wait()
        if pid == nil then
            break
        end
    end
end

return Start
