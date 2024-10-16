local Mapping = {}

function Mapping.Spawn(modkeys, keybind, command)
    local modkeys_str = table.concat(modkeys, "+")
    local cmd = string.format('riverctl map normal %s %s spawn "%s"', modkeys_str, keybind, command)

    os.execute(cmd)
end

function Mapping.Action(modkeys, keybind, option)
    local modkeys_str = table.concat(modkeys, "+")
    local cmd = string.format("riverctl map normal %s %s %s", modkeys_str, keybind, option)

    os.execute(cmd)
end

function Mapping.Pointer(modkeys, keybind, option)
    local modkeys_str = table.concat(modkeys, "+")
    local cmd = string.format("riverctl map-pointer normal %s %s %s", modkeys_str, keybind, option)

    os.execute(cmd)
end

function Mapping.Property(property, value)
    local cmd = string.format("riverctl %s %s", property:gsub("_", "-"), value)

    os.execute(cmd)
end

function Mapping.Move(modkeys, keybind, direction, value)
    local modkeys_str = table.concat(modkeys, "+")
    local cmd = string.format("riverctl map normal %s %s move %s %s", modkeys_str, keybind, direction, value)

    os.execute(cmd)
end

function Mapping.Snap(modkeys, keybind, direction)
    local modkeys_str = table.concat(modkeys, "+")
    local cmd = string.format("riverctl map normal %s %s snap %s", modkeys_str, keybind, direction)

    os.execute(cmd)
end

function Mapping.Resize(modkeys, keybind, direction, value)
    local modkeys_str = table.concat(modkeys, "+")
    local cmd = string.format("riverctl map normal %s %s resize %s %s", modkeys_str, keybind, direction, value)

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

function Mapping.ViewRule(id, rule)
    local cmd = string.format("riverctl rule-add -app-id %s %s", id, rule)

    os.execute(cmd)
end

function Mapping.ViewRuleTags(id, tag)
    local cmd = string.format("riverctl rule-add -app-id %s tags %s", id, tags[tag])

    os.execute(cmd)
end

function Mapping.ViewSSD(id)
    local cmd = string.format("riverctl rule-add -app-id %s ssd", id)

    os.execute(cmd)
end

function Mapping.SetFocusedTag(modkeys, keybind, tag)
    local modkeys_str = table.concat(modkeys, "+")
    local cmd = string.format(
        "riverctl map normal %s %s set-focused-tags %s", modkeys_str, keybind, tags[tag])

    os.execute(cmd)
end

function Mapping.SetViewTag(modkeys, keybind, tag)
    local modkeys_str = table.concat(modkeys, "+")
    local cmd = string.format(
        "riverctl map normal %s %s set-view-tags %s", modkeys_str, keybind, tags[tag])

    os.execute(cmd)
end

function Mapping.ToggleFocusedTag(modkeys, keybind, tag)
    local modkeys_str = table.concat(modkeys, "+")
    local cmd = string.format(
        "riverctl map normal %s %s toggle-focused-tags %s", modkeys_str, keybind, tags[tag])

    os.execute(cmd)
end

function Mapping.ToggleViewTag(modkeys, keybind, tag)
    local modkeys_str = table.concat(modkeys, "+")
    local cmd = string.format(
        "riverctl map normal %s %s toggle-view-tags %s", modkeys_str, keybind, tags[tag])

    os.execute(cmd)
end

return Mapping
