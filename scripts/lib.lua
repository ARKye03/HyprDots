local Lib = {}

function Lib.Notify(message, urgency, timeout)
    urgency = urgency or "normal"
    timeout = timeout or 2000
    os.execute('notify-send -u ' .. urgency .. ' -t ' .. timeout .. ' "' .. message .. '"')
end

return Lib
