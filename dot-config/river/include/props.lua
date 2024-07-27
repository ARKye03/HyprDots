local Utils = require('utils')

function Props()
    local opts = {
        -- Theme options
        background_color = "0x181825",
        border_color_focused = "0x8aadf4",
        border_color_unfocused = "0x586e75",

        focus_follows_cursor = "normal",
        -- Keyboard
        set_repeat = "50 300",

        default_layout = "rivertile",
    }

    for prop, value in pairs(opts) do
        Utils.Property(prop, value)
    end
end

return Props
