#! /usr/bin/env lua

-- Function to prompt for password securely
local function prompt_password()
  io.write("Enter your password: ")
  io.flush()
  os.execute("stty -echo") -- Disable echo
  local password = io.read()
  os.execute("stty echo")  -- Enable echo
  io.write("\n")
  return password
end

-- Function to run commands as superuser
local function run_as_superuser(commands)
  local password = prompt_password()
  local sudo_command = string.format("echo %s | sudo -S -i bash -c '%s'", password, table.concat(commands, " && "))
  local result = os.execute(sudo_command)
  return result
end

local commands = {
  "pacman -Qdtq | pacman -Rns -",
  "pacman -Qqd | pacman -Rsu -",
  "pacman -Scc --noconfirm && yay -Scc --noconfirm",
  "paccache -rk0",
  "fstrim -av",
}

local result = run_as_superuser(commands)
if result then
  print("Cleanup completed successfully")
else
  print("Cleanup failed")
end
