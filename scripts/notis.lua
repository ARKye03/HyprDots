#!/usr/bin/env lua

local os = require('os')

local function notify_send(args, title, message)
    os.execute('notify-send ' .. args .. ' "' .. title .. '" "' .. message .. '"')
    os.execute('sleep 1')
end

local notifications = {
    { args = "",                          title = "Hello, World!",               message = "" },
    { args = "",                          title = "Title",                       message = "This is a notification with a title." },
    { args = "",                          title = "Long Message",                message = "This is a notification with a longer message that might wrap onto multiple lines in the notification window." },
    { args = '-i /path/to/icon.png',      title = "Icon Notification",           message = "This notification includes an icon." },
    { args = '-u critical',               title = "Critical Notification",       message = "This is a critical notification." },
    { args = '-t 50',                     title = "Temporary Notification",      message = "This notification will disappear after 5 seconds." },
    { args = '-A "action1" -A "action2"', title = "Action Notification",         message = "This notification has actions." },
    { args = '-h int:urgency:2',          title = "Hint Notification",           message = "This notification uses a hint to set the urgency level." },
    { args = '-h int:timeout:10',         title = "Custom Timeout Notification", message = "This notification will disappear after 10 seconds." },
    { args = '-c "email.arrived"',        title = "New Email",                   message = "You have a new email." },
    { args = '-A "MyApp"',                title = "App Notification",            message = "This notification comes from MyApp." }
}

for _, notification in ipairs(notifications) do
    notify_send(notification.args, notification.title, notification.message)
end
