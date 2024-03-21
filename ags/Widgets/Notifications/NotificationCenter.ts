import { icons } from "assets/Assets";
import Notification, {
  Notification as NotificationService,
} from "resource:///com/github/Aylur/ags/service/notifications.js";

const notifications = Notification;
notifications.popupTimeout = 3000;
notifications.forceTimeout = false;
notifications.cacheActions = false;
notifications.clearDelay = 50;

const MAX_HEIGHT = 780;
const NOTIFICATION_HEIGHT = 80;

export const CurrentNotifications = Widget.Label({
  label: notifications.bind("notifications").as((n) => `${n.length}`),
});

const createNotificationWidget = (notification: NotificationService) => {
  const actionButtons = notification.actions.map((action) =>
    Widget.Button({
      label: action.label,
      hexpand: true, // Make the button expand to fill the available space
      on_primary_click_release: () => notification.invoke(action.id),
    })
  );

  return Widget.Box({
    vertical: true,
    class_name: "notification-widget",
    children: [
      Widget.Label({
        class_name: `notification-title-${notification.urgency}`,
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
      Widget.Box({
        vexpand: false,
        hexpand: false,
        children: actionButtons,
      }),
    ],
  });
};

//@ts-ignore
const notificationContainer = Widget.Box({
  vertical: true,
  vexpand: true,
  children: notifications
    .bind("notifications")
    .as((n) =>
      n.length === 0
        ? [Widget.Label("There are no notifications")]
        : n.map(createNotificationWidget)
    ),
});
const scrolledWindow = Widget.Scrollable({
  class_name: "scroll_notifications",
  child: notificationContainer,
});

notifications.connect("notified", () => {
  const numNotifications = notifications.notifications.length;
  scrolledWindow.height_request = Math.min(
    numNotifications * NOTIFICATION_HEIGHT,
    MAX_HEIGHT
  );
});
notifications.connect("closed", () => {
  const numNotifications = notifications.notifications.length;
  scrolledWindow.height_request = Math.min(
    numNotifications * NOTIFICATION_HEIGHT,
    MAX_HEIGHT
  );
});

export const notificationSideBar = Widget.Window({
  name: "notificationSideBar",
  visible: false,
  class_name: "notification-sidebar",
  anchor: ["right", "bottom"],
  child: Widget.Box({
    vertical: true,
    children: [
      scrolledWindow,
      Widget.Box({
        class_name: "notification-clear-icon",
        homogeneous: true,
        children: [
          Widget.Button({
            on_primary_click_release: () => Notification.Clear(),
            child: Widget.Icon({
              icon: icons.trashNotificationsSvg,
              size: 20,
            }),
          }),
          Widget.Button({
            on_primary_click_release: () =>
              App.ToggleWindow("notificationSideBar"),
            child: Widget.Icon({
              icon: icons.closeChatSvg,
              size: 20,
            }),
          }),
        ],
      }),
    ],
  }),
});
