import App from "resource:///com/github/Aylur/ags/app.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { Workspaces } from "./Widgets/Workspaces";
import { MusicPlayerDaemon } from "./Widgets/MusicPlayerDaemon";
import { Power, Rofi } from "./Widgets/BorderMenus";
import { Volume } from "./Widgets/Volume";
import { SysTray } from "./Widgets/SysTray";
import { Clock } from "./Widgets/Clock";
import { notificationPopup } from "./Widgets/NotificationPops";

const Left = () =>
  Widget.Box({
    children: [Power, Workspaces()],
  });

const Center = () =>
  Widget.Box({
    children: [MusicPlayerDaemon],
  });

const Right = () =>
  Widget.Box({
    hpack: "end",
    children: [Volume(), Clock(), SysTray(), Rofi],
  });

const Bar = (monitor = 0) =>
  Widget.Window({
    name: `bar-${monitor}`,
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(),
      end_widget: Right(),
    }),
  });

App.config({
  style: "./style.css",
  windows: [Bar(), notificationPopup],
});
