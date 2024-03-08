import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { Workspaces } from "./Workspaces";
import { MusicPlayerDaemon } from "./MusicPlayerDaemon";
import { Power, Rofi } from "./BorderMenus";
import { Volume } from "./Volume";
import { SysTray } from "./SysTray";
import { Clock } from "./Clock";

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
export const Bar = (monitor = 0) =>
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
