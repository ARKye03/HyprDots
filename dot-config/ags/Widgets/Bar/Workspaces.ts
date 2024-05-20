import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

export const Workspaces = () =>
  Widget.Box({
    className: "workspaces",
    setup: (self) => {
      const Wicons = [
        "",
        " ",
        " ",
        "󰨞 ",
        " ",
        " ",
        " ",
        " ",
        " ",
        "󰊖 ",
        " ",
      ];
      const arr = Array.from({ length: 10 }, (_, i) => i + 1);

      const updateWorkspaces = () => {
        self.children = arr.map((i) => {
          let className = ""; // default value

          if (Hyprland.active.workspace.id === i) {
            className = "focused";
          } else if (
            Hyprland.workspaces.some((ws) => ws.id === i && ws.windows > 0)
          ) {
            className = "work";
          }

          return Widget.Button({
            onClicked: () =>
              execAsync(`/usr/bin/hyprctl dispatch workspace ${i}`),
            child: Widget.Label(`${Wicons[i]}`),
            className: className,
          });
        });
      };

      self.hook(Hyprland.active.workspace, updateWorkspaces, "changed");
      updateWorkspaces();
    },
  });
