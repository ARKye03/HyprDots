// importing
import App from "resource:///com/github/Aylur/ags/app.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { Workspaces } from "./Widgets/Workspaces.js";
import { Notification } from "./Widgets/Notification.js";
import { MusicPlayerDaemon } from "./Widgets/MusicPlayerDaemon.js";
import { Power, Rofi } from "./Widgets/BorderMenus.js";
import { Volume } from "./Widgets/Volume.js";
import { SysTray } from "./Widgets/SysTray.js";
import { Clock } from "./Widgets/Clock.js";

// layout of the bar
const Left = () =>
  Widget.Box({
    children: [Power, Workspaces()],
  });

const Center = () =>
  Widget.Box({
    children: [MusicPlayerDaemon, Notification()],
  });

const Right = () =>
  Widget.Box({
    hpack: "end",
    children: [Volume(), Clock(), SysTray(), Rofi],
  });

const Bar = (monitor = 0) =>
  Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
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
  windows: [Bar()],
});
