import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import { CurrentNotifications } from "Widgets/Notifications/NotificationCenter";

export const PowerMenu = Widget.Box({
  className: "bc",
  children: [
    Widget.Button({
      on_primary_click_release: () => App.ToggleWindow("notificationSideBar"),
      child: CurrentNotifications,
    }),
    Widget.Button({
      child: Widget.Label(" ⏻ "),
      on_primary_click_release: () =>
        execAsync(`/home/archkye/.config/rofi/powermenu/type-4/powermenu.sh`),
    }),
  ],
});
export const AppLauncher = Widget.Button({
  className: "bc",
  child: Widget.Label(" 󱓞 "),
  on_primary_click_release: () =>
    execAsync(`/home/archkye/.config/rofi/launchers/type-3/launcher.sh`),
});
