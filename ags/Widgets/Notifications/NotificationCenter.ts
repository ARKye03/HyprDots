import { icons } from "assets/Assets";
import Notification, {
  Notification as NotificationService,
} from "resource:///com/github/Aylur/ags/service/notifications.js";

const notifications = Notification;
notifications.popupTimeout = 3000;
notifications.forceTimeout = false;
notifications.cacheActions = false;
notifications.clearDelay = 100;

export const CurrentNotifications = Widget.Label({
  label: notifications.bind("notifications").as((n) => `${n.length}`),
});
const createNotificationWidget = (notification: NotificationService) => {
  return Widget.Box({
    vertical: true,
    class_name: "notification-widget",
    children: [
      Widget.Label({
        class_name: "notification-title",
        justification: "center",
        use_markup: true,
        wrap: true,
        label: notification.summary,
      }),
      Widget.Label({
        class_name: "notification-body",
        justification: "center",
        use_markup: true,
        wrap: true,
        label: notification.body,
      }),
    ],
  });
};

export const notificationSideBar = Widget.Window({
  name: "notificationSideBar",
  visible: false,
  class_name: "notification-sidebar",
  width_request: 350,
  anchor: ["top", "right", "bottom"],
  child: Widget.Box({
    vertical: true,
    children: [
      Widget.Scrollable({
        class_name: "scroll_notifications",
        width_request: 300,
        child: Widget.Box({
          vertical: true,
          vexpand: true,
          children: notifications
            .bind("notifications")
            .as((n) => n.slice(-50).map(createNotificationWidget)), // Only take the last 50 notifications
        }),
      }),
      Widget.Button({
        on_primary_click_release: () => Notification.Clear(),
        child: Widget.Icon({
          icon: icons.trashNotificationsSvg,
          size: 20,
        }),
      }),
    ],
  }),
});
