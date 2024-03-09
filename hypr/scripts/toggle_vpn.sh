##!/bin/bash

# Check the status of the VPN
vpn_status=$(protonvpn-cli status)

# Check if the VPN is connected
if echo "$vpn_status" | grep -q "Country"; then
  # If the VPN is connected, disconnect it
  hyprctl notify 1 2000 "rgb(ff1ea3)" "Disconnecting Proton VPN"
  protonvpn-cli d
  hyprctl notify 1 3000 "rgb(00ce71)" "Disconnected"
else
  # If the VPN is not connected, connect it
  hyprctl notify 1 10000 "rgb(f1eca3)" "Connecting Proton VPN"
  protonvpn-cli c --cc US -p udp
  if [ $? -eq 0 ]; then
    # Get the server information
    vpn_status=$(protonvpn-cli status)
    server_info=$(echo "$vpn_status" | grep "Server:" | awk '{print $2}')
    hyprctl notify 5 6000 "rgb(00ce71)" "Connected to $server_info"
  else
    hyprctl notify 5 10000 "rgb(ce0000)" "Failed to connect"
  fi
fi
