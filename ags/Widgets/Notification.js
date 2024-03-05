import { notifications } from "resource:///com/github/Aylur/ags/service/notifications.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";

export function Notification() {
  const popups = notifications.bind("popups");
  return Widget.Box({
    class_name: "notification",
    visible: popups.as((p) => p.length > 0),
    children: [
      Widget.Icon({
        icon: "preferences-system-notifications-symbolic",
      }),
      Widget.Label({
        label: popups.as((p) => p[0]?.summary || ""),
      }),
    ],
  });
}
