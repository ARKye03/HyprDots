#!/usr/bin/env lua
-- file: gss.lua
local os = require('os')

local function region_screenshot()
  os.execute('grim -g "$(slurp)" - | swappy -f -')
end

local function file_screenshot()
  os.execute('swappy -f "~/Desktop/my-gnome-saved-file.png"')
end

local function stdout_screenshot()
  os.execute('grim -g "$(slurp)" - | swappy -f - -o - | pngquant -')
end

local function window_screenshot()
  os.execute(
    'grim -g "$(hyprctl -j activewindow | jq -r \'"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])"\')" - | swappy -f -')
end

local function full_screenshot()
  local status = os.execute('grim')
  if status == 0 then
    os.execute('notify-send -u low -t 2000 "Screenshot stored in ~/Pictures"')
  end
end

local function custom_slurp()
  local output = os.execute('slurp -d -c #ffffff -b #00000000')
  os.execute('notify-send "The measure is:" "' .. output .. '" -u low')
end

local arg = arg[1]
if arg == "region" then
  region_screenshot()
elseif arg == "file" then
  file_screenshot()
elseif arg == "stdout" then
  stdout_screenshot()
elseif arg == "window" then
  window_screenshot()
elseif arg == "full" then
  full_screenshot()
elseif arg == "aspect_visualizer" then
  custom_slurp()
else
  print("Invalid argument. Please use one of the following: region, file, stdout, window, full, custom")
end
