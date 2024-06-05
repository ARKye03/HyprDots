#!/usr/bin/env lua
-- file: listPkgs.lua
local handle = io.popen("pacman -Qe")
if handle ~= nil then
    local result = handle:read("*a")
    handle:close()

    local lines = {}
    for s in result:gmatch("[^\r\n]+") do
        table.insert(lines, s)
    end

    local markdown = "# Zoore Arch Installed Packages\n\n| Package  | Version |\n| -------  | ------- |\n"
    for _, line in ipairs(lines) do
        local package, version = line:match("(%S+)%s+(%S+)")
        markdown = markdown .. "| " .. package .. " | " .. version .. " |\n"
    end

    local file = io.open("INSTALLEDPKGS.MD", "w")
    if file ~= nil then
        file:write(markdown)
        file:close()
    else
        print("Failed to open file")
    end
else
    print("Failed to open handle")
end
