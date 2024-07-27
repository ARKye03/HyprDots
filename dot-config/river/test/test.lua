local Utils = require('utils')

-- Utils.Spawn({ "Super" }, "Return", "/usr/bin/alacritty")
-- Utils.Spawn({ "Super" }, "M",
--     "/usr/bin/alacritty --class floatcritty -e /usr/bin/ncmpcpp -c " .. os.getenv("HOME") .. "/.ncmpcpp/config")

Utils.Spawn({ "Super" }, "V", os.getenv("HOME") .. "/.dotfiles/scripts/toggle_vpn.lua")

Utils.Action({ "Super" }, "Space", "toggle-float")
