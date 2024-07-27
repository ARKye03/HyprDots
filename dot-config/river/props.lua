local Utils = require('utils')

function Props()
    local opts = {
        -- Theme options
        background_color = "0x181825",
        border_color_focused = "0x8aadf4",
        border_color_unfocused = "0x586e75",

        -- Keyboard
        set_repeat = "50 300",

        -- Layout
        default_layout = "rivertile",
    }

    Utils.Property("background-color", opts.background_color)
    Utils.Property("border-color-focused", opts.border_color_focused)
    Utils.Property("border-color-unfocused", opts.border_color_unfocused)
    Utils.Property("set-repeat", opts.set_repeat)
    Utils.Property("default-layout", opts.default_layout)
end

return Props
