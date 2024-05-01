#!/bin/bash

# Basic notification
notify-send "Hello, World!"
sleep 1
# Notification with a title
notify-send "Title" "This is a notification with a title."
sleep 1
# Notification with a longer message
notify-send "Long Message" "This is a notification with a longer message that might wrap onto multiple lines in the notification window."
sleep 1
# Notification with an icon
notify-send -i /path/to/icon.png "Icon Notification" "This notification includes an icon."
sleep 1
# Notification with a different urgency level
# Urgency levels are: low, normal, critical
notify-send -u critical "Critical Notification" "This is a critical notification."
sleep 1
# Notification that expires after a certain time (in milliseconds)
# Here, the notification will disappear after 50 milliseconds (5 seconds)
notify-send -t 50 "Temporary Notification" "This notification will disappear after 5 seconds."
sleep 1
# Notification with actions
# Note: This requires a notification server that supports actions, like dunst or notify-osd
notify-send -a "action1" -a "action2" "Action Notification" "This notification has actions."
sleep 1
# Notification with hints
# Hints are used to provide additional information to the notification server
# Here, we're setting the urgency level using a hint
notify-send "Hint Notification" "This notification uses a hint to set the urgency level." -h int:urgency:2
sleep 1
# Notification with a custom timeout
# This is similar to the -t opion but allows for more granular control
# Here, the notification will disappear after 10 seconds
notify-send "Custom Timeout Notification" "This notification will disappear after 10 seconds." -h int:timeout:10
sleep 1
# Notification with a custom category
# Categories can be used to group notifications
notify-send -c "email.arrived" "New Email" "You have a new email."
sleep 1
# Notification with a custom app name
# This can be useful for distinguishing notifications from different applications
notify-send -a "MyApp" "App Notification" "This notification comes from MyApp."
sleep 1
