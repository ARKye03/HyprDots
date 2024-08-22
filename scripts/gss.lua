#!/usr/bin/env lua

-- Get the directory of the current script
local script_dir = debug.getinfo(1).source:match("@?(.*/)")
package.path = script_dir .. "?.lua;" .. package.path

local lib = require('lib')
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
    lib.Notify("Screenshot stored in ~/Pictures", "low", 2000)
  end
end

local function custom_slurp()
  local handle = io.popen('slurp -d -c "#ffffff" -b "#00000000"')
  local output = handle and handle:read("*a") or ""
  if handle then
    handle:close()
  end

  if output == nil or output == "" then
    output = "No output from slurp"
  end

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
