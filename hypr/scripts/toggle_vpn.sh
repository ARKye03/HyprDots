#!/bin/bash

# This script toggles the connection status of a ProtonVPN.
# It checks the current status of the VPN and either connects or disconnects it accordingly.

# Check the status of the VPN
vpn_status=$(protonvpn-cli status)

# Check if the VPN is connected
if echo "$vpn_status" | grep -q "Country"; then
  # If the VPN is connected, disconnect it
  notify-send -u critical -i dialog-warning "Disconnecting Proton VPN"
  protonvpn-cli d
  notify-send -u normal -i dialog-information "Disconnected"
else
  # If the VPN is not connected, connect it
  notify-send -u low -i dialog-information "Connecting Proton VPN"
  protonvpn-cli c --cc US -p udp
  if [ $? -eq 0 ]; then
    # Get the server information
    vpn_status=$(protonvpn-cli status)
    server_info=$(echo "$vpn_status" | grep "Server:" | awk '{print $2}')
    notify-send -u low -i dialog-information "ProtonVPN Connected:" "$server_info"
  else
    notify-send -u critical -i dialog-error "Failed to connect"
  fi
fi