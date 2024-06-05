#!/usr/bin/env lua
-- file: toggle_vpn.lua
local os = require('os')

local function execute_command(command)
	local handle = io.popen(command)
	local result = ""
	if handle then
		result = handle:read("*a")
		handle:close()
	end
	return result
end

local function notify_send(args, title, message)
	os.execute('notify-send ' .. args .. ' "' .. title .. '" "' .. message .. '"')
end

local function connect_vpn()
	notify_send("-u low -i dialog-information", "Connecting Proton VPN", "")
	local status = os.execute('protonvpn-cli c --cc US -p udp')
	if status == 0 then
		local vpn_status = execute_command('protonvpn-cli status')
		local server_info = vpn_status:match("Server: (%S+)")
		notify_send("-u low -i dialog-information", "ProtonVPN Connected:", server_info)
	else
		notify_send("-u critical -i dialog-error", "Failed to connect", "-A Retry -A Dismiss")
		local response = os.execute('notify-send -u low "$?"')
		if response == 0 then
			connect_vpn()
		end
	end
end

local vpn_status = execute_command('protonvpn-cli status')

if vpn_status:find("Country") then
	notify_send("-u critical -i dialog-warning", "Disconnecting Proton VPN", "")
	os.execute('protonvpn-cli d')
	notify_send("-u normal -i dialog-information", "Disconnected", "")
else
	connect_vpn()
end
