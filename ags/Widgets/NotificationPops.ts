const notifications = await Service.import("notifications");
notifications.popupTimeout = 3000;
notifications.forceTimeout = false;
notifications.cacheActions = false;
notifications.clearDelay = 100;

Widget.Label({
  label: notifications
    .bind("notifications")
    .as((n) => `there are ${n.length} notifications`),
});
const popups = notifications.bind("popups");

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} n */
const NotificationIcon = ({ app_entry, app_icon, image }) => {
  if (image) {
    return Widget.Box({
      css: `
                background-image: url("${image}");
                background-size: contain;
                background-repeat: no-repeat;
                background-position: center;
            `,
    });
  }

  let icon = "dialog-information-symbolic";
  if (Utils.lookUpIcon(app_icon)) icon = app_icon;

  if (app_entry && Utils.lookUpIcon(app_entry)) icon = app_entry;

  return Widget.Icon(icon);
};

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} n */
export const Notification = (n) => {
  const title = Widget.Label({
    class_name: "title",
    xalign: 0,
    justification: "left",
    hexpand: true,
    max_width_chars: 24,
    truncate: "end",
    wrap: true,
    label: n.summary,
    use_markup: true,
  });

  const body = Widget.Label({
    class_name: "body",
    hexpand: true,
    use_markup: true,
    xalign: 0,
    justification: "left",
    label: n.body,
    wrap: true,
  });

  const actions = Widget.Box({
    class_name: "actions",
    children: n.actions.map(({ id, label }) =>
      Widget.Button({
        class_name: "action-button",
        on_clicked: () => n.invoke(id),
        hexpand: true,
        child: Widget.Label(label),
      })
    ),
  });

  return Widget.EventBox({
    on_primary_click: () => n.dismiss(),
    child: Widget.Box({
      class_name: `notification ${n.urgency}`,
      vertical: true,
      children: [
        Widget.Box({
          children: [
            Widget.Box({
              vertical: true,
              children: [title, body],
            }),
          ],
        }),
        actions,
      ],
    }),
  });
};

const notificationBox = Widget.Box({
  class_name: "notifications",
  vertical: true,
  children: popups.as((popups) => {
    const styleContext = notificationBox.get_style_context();
    // Add the 'show' class when there are popups
    if (popups.length > 0) {
      styleContext.add_class("show");
    } else {
      styleContext.remove_class("show");
    }
    return popups.map(Notification);
  }),
});

export const notificationPopup = Widget.Window({
  name: "notifications",
  anchor: ["top", "right"],
  child: notificationBox,
});
