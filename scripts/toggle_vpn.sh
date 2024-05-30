#!/bin/bash

# This script toggles the connection status of a ProtonVPN.
# It checks the current status of the VPN and either connects or disconnects it accordingly.

# Function to connect to ProtonVPN
connect_vpn() {
	notify-send -u low -i dialog-information "Connecting Proton VPN"
	protonvpn-cli c --cc US -p udp
	if [ $? -eq 0 ]; then
		# Get the server information
		vpn_status=$(protonvpn-cli status)
		server_info=$(echo "$vpn_status" | grep "Server:" | awk '{print $2}')
		notify-send -u low -i dialog-information "ProtonVPN Connected:" "$server_info"
	else
		# If connection fails, prompt the user with Retry and Dismiss options
		notify-send -u critical -i dialog-error "Failed to connect" -A "Retry" -A "Dismiss"
		# Capture the exit status of notify-send
		response=$?
		notify-send -u low "$response"
		if [ $response -eq 0 ]; then
			# If Retry is selected, reconnect
			connect_vpn
		fi
	fi
}

# Check the status of the VPN
vpn_status=$(protonvpn-cli status)

# Check if the VPN is connected
if echo "$vpn_status" | grep -q "Country"; then
	# If the VPN is connected, disconnect it
	notify-send -u critical -i dialog-warning "Disconnecting Proton VPN"
	protonvpn-cli d
	notify-send -u normal -i dialog-information "Disconnected"
else
	# If the VPN is not connected, call the connect function
	connect_vpn
fi
