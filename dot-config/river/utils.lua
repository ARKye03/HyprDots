-- riverctl map normal Super Tab focus-previous-tags
-- riverctl map normal Super Return spawn /usr/bin/alacritty

local Mapping = {}

function Mapping.Spawn(modkeys, keybind, command)
    -- Concatenate the modifier keys with a `+` separator
    local modkeys_str = table.concat(modkeys, "+")

    -- Construct the command string
    local cmd = string.format("riverctl map normal %s %s spawn %s", modkeys_str, keybind, command)

    -- Execute the command
    os.execute(cmd)
end

function Mapping.Action(modkeys, keybind, option)
    local modkeys_str = table.concat(modkeys, "+")
    local cmd = string.format("riverctl map normal %s %s %s", modkeys_str, keybind, option)

    os.execute(cmd)
end

local tags = {
    [1] = 1,
    [2] = 2,
    [3] = 4,
    [4] = 8,
    [5] = 16,
    [6] = 32,
    [7] = 64,
    [8] = 128,
    [9] = 256,

}

function Mapping.ViewRule(id, tag)
    local cmd = string.format("riverctl rule-add -app-id %s tags $s", id, tags[tag])
    os.execute(cmd)
end

function Mapping.ViewSSD(id)
    local cmd = string.format("riverctl rule-add -app-id %s ssd", id)
    os.execute(cmd)
end

function Mapping.SetFocusedTag(modkeys, keybind, tag)
    local cmd = string.format(
        "riverctl map normal %s %s set-focused-tags %s", modkeys, keybind, tags[tag])
    os.execute(cmd)
end

function Mapping.SetViewTag(modkeys, keybind, tag)
    local cmd = string.format(
        "riverctl map normal %s %s set-view-tags %s", modkeys, keybind, tags[tag])
    os.execute(cmd)
end

function Mapping.ToggleFocusedTag(modkeys, keybind, tag)
    local cmd = string.format(
        "riverctl map normal %s %s toggle-focused-tags %s", modkeys, keybind, tags[tag])
    os.execute(cmd)
end

function Mapping.ToggleViewTag(modkeys, keybind, tag)
    local cmd = string.format(
        "riverctl map normal %s %s toggle-view-tags %s", modkeys, keybind, tags[tag])
    os.execute(cmd)
end

return Mapping
