#!/usr/bin/env lua
-- file: eclean.lua
local os = require('os')

local function notify_send(message)
  os.execute('notify-send "' .. message .. '"')
end

local function execute_command(command)
  local handle = io.popen(command)
  local result = handle and handle:read("*a")
  if handle then
    handle:close()
  end
  return result
end

notify_send("Cleaning up the system...")

local commands = {
  'pacman -Qdtq | pacman -Rns -',
  'pacman -Qqd | pacman -Rsu -',
  'pacman -Scc --noconfirm && yay -Scc --noconfirm',
  'paccache -rk0',
  'fstrim -av'
}

for _, command in ipairs(commands) do
  local result = execute_command('sudo sh -c \'' .. command .. '\'')
  if result ~= "" then
    notify_send("System cleanup failed!")
    os.exit(1)
  end
end

notify_send("System cleanup complete!")
