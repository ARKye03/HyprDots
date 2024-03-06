import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

export const Rofi = Widget.Button({
  className: "bc",
  child: Widget.Label(" ⏻ "),
  on_primary_click_release: () =>
    execAsync(`/home/archkye/.config/rofi/powermenu/type-4/powermenu.sh`),
});
export const Power = Widget.Button({
  className: "bc",
  child: Widget.Label(" 󱓞 "),
  on_primary_click_release: () =>
    execAsync(`/home/archkye/.config/rofi/launchers/type-3/launcher.sh`),
});
