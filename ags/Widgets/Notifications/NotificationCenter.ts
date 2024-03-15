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
        justification: "center",
        use_markup: true,
        wrap: true,
        label: notification.summary,
      }),
      Widget.Label({
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
  child: Widget.Scrollable({
    class_name: "scroll_notifications",
    width_request: 300,
    child: Widget.Box({
      vertical: true,
      children: notifications
        .bind("notifications")
        .as((n) => n.slice(-50).map(createNotificationWidget)), // Only take the last 50 notifications
    }),
  }),
});
