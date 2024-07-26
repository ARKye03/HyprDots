local Utils = require('utils')

function ViewRules()
    local ssds = {
        "org.gnome.Loupe",
        "Alacritty",
        "dev.zed.Zed",
        "thunar",
        "uget-gtk",
        "io.github.celluloid_player.Celluloid",
        "nwg-look",
        "dev.warp.Warp"
    }

    for _, value in ipairs(ssds) do
        Utils.ViewSSD(value)
    end

    local ViewMatrix = {
        [1] = { 'dev.warp.Warp' },
        [2] = { 'brave-browser' },
        [3] = { 'code-url-handler', 'dev.zed.Zed' },
        [4] = { 'thunar' },
        [5] = { 'libreoffice-*' },
        [6] = { 'org.telegram.desktop', 'discord' },
        [7] = { 'io.github.celluloid_player.Celluloid', 'vlc' },
        [8] = { 'uget-gtk' },
        [9] = { 'Gimp-2.10' },
    }

    for tag, apps in pairs(ViewMatrix) do
        for _, app in ipairs(apps) do
            Utils.ViewRule(app, tag)
        end
    end
end

return ViewRules
