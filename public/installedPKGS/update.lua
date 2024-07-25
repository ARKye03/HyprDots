#!/usr/bin/env lua

local HOME = os.getenv("HOME")
local pkgsDir = HOME .. "/.dotfiles/public/installedPKGS/"
local pkgsScript = pkgsDir .. "listPkgs.lua"

local yay = "yay"
local pacman = "sudo pacman"
local pacman_warp_conf = "/etc/pacman-warp.conf"

local regular_update = pacman .. " -Syu --noconfirm" .. " && " .. yay .. " -Syu --noconfirm"
local warp_update = pacman
	.. " -Syu --noconfirm --config "
	.. pacman_warp_conf
	.. " && "
	.. yay
	.. " -Syu --noconfirm --config "
	.. pacman_warp_conf

local function updatePackages()
	os.execute(pkgsScript)
	os.execute("git add " .. pkgsDir .. "README.md")
	os.execute("git commit -m 'Update installed packages'")
end

local function perform_update(use_warp)
	local update_command = use_warp and warp_update or regular_update
	local success, exitType, exitCode = os.execute(update_command)
	if success and (exitType == "exit" and exitCode == 0) then
		updatePackages()
	else
		local updateType = use_warp and "Warp" or "Regular"
		print(
			updateType
			.. " update failed with exit reason: "
			.. tostring(exitType)
			.. ", exit code: "
			.. tostring(exitCode)
		)
	end
end

-- Check the command line arguments
local arg = arg[1]
if arg == "pacsu" then
	perform_update(false)
elseif arg == "pacsuw" then
	perform_update(true)
else
	print("Invalid command. Use pacsu or pacsuw.")
end
