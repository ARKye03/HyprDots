#!/usr/bin/env lua
-- file: WBG.lua
local os = require('os')
local io = require('io')

-- Directory containing the wallpapers
local wallpaper_dir = os.getenv("HOME") .. "/backgrounds/wallpapers"

-- File to store the current wallpaper index
local index_file = "./current_index.txt"

-- Function to get all wallpapers
local function get_wallpapers()
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -a "' .. wallpaper_dir .. '"')
  if pfile ~= nil then
    for filename in pfile:lines() do
      i = i + 1
      t[i] = wallpaper_dir .. '/' .. filename -- Prepend the directory path
    end
    pfile:close()
  else
    print("Failed to open file")
  end
  return t
end
-- Array of all wallpapers
local wallpapers = get_wallpapers()

-- Number of wallpapers
local num_wallpapers = #wallpapers

-- Function to select a specific wallpaper
local function select_wallpaper(index)
  os.execute('killall wbg')
  os.execute('wbg "' .. wallpapers[index] .. '"')
  local file = io.open(index_file, "w")
  if file ~= nil then
    file:write(index)
    file:close()
  end
end

-- Function to select a random wallpaper
local function random_wallpaper()
  os.execute('killall wbg')
  local rand_index = math.random(num_wallpapers)
  os.execute('wbg "' .. wallpapers[rand_index] .. '"')
  local file = io.open(index_file, "w")
  if file ~= nil then
    file:write(rand_index)
    file:close()
  end
end

-- Function to select the next wallpaper
local function next_wallpaper()
  os.execute('killall wbg')
  -- Get the current wallpaper index
  local file = io.open(index_file, "r")
  local current_index
  if file ~= nil then
    current_index = file:read("*n")
    file:close()
  end
  local next_index -- Declare next_index here
  if current_index ~= nil then
    -- Calculate the next index
    next_index = (current_index + 1) % num_wallpapers
    -- Write the new index to the file
    local file_write = io.open(index_file, "w") -- Use a different variable name
    if file_write ~= nil then
      file_write:write(next_index)
      file_write:close()
    end
  end
  -- Set the next wallpaper
  os.execute('wbg "' .. wallpapers[next_index] .. '"')
end

-- Function to select the previous wallpaper
local function prev_wallpaper()
  os.execute('killall wbg')
  -- Get the current wallpaper index
  local file = io.open(index_file, "r")
  local current_index
  if file ~= nil then
    current_index = file:read("*n")
    file:close()
  end
  local prev_index -- Declare prev_index here
  if current_index ~= nil then
    -- Calculate the previous index
    prev_index = (current_index - 1 + num_wallpapers) % num_wallpapers
    -- Write the new index to the file
    local file_write = io.open(index_file, "w") -- Use a different variable name
    if file_write ~= nil then
      file_write:write(prev_index)
      file_write:close()
    end
  end
  -- Set the previous wallpaper
  os.execute('wbg "' .. wallpapers[prev_index] .. '"')
end
-- Check the command line arguments
local arg = arg[1]
if arg == "select" then
  select_wallpaper(arg[2])
elseif arg == "random" then
  random_wallpaper()
elseif arg == "next" then
  next_wallpaper()
elseif arg == "prev" then
  prev_wallpaper()
else
  print("Invalid command. Use 'select', 'random', 'next', or 'prev'.")
end
