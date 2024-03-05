// importing
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import { notifications } from "resource:///com/github/Aylur/ags/service/notifications.js";
import Audio from "resource:///com/github/Aylur/ags/service/audio.js";
import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";
import App from "resource:///com/github/Aylur/ags/app.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

//#region Works2
// Dynamic sway-like workspaces
// function Workspaces() {
//   const workspaces = Hyprland.bind("workspaces");
//   const activeId = Hyprland.active.workspace.bind("id");

//   const Wicons = [
//     "",
//     " ",
//     " ",
//     "󰨞 ",
//     " ",
//     " ",
//     " ",
//     " ",
//     " ",
//     "󰊖 ",
//     " ",
//   ];

//   return Widget.Box({
//     className: "workspaces",
//     children: workspaces.as((ws) =>
//       ws.map(({ id, windows }) => {
//         let className = "bc"; // default value

//         if (activeId[1] === id) {
//           className = "focused";
//         } else if (windows > 0) {
//           className = "work";
//         }

//         return Widget.Button({
//           onClicked: () => Hyprland.messageAsync(`dispatch workspace ${id}`),
//           child: Widget.Label(`${Wicons[id]}`),
//           className: className,
//         });
//       })
//     ),
//   });
// }
//#endregion

const Workspaces = () =>
  Widget.Box({
    className: "workspaces",
    // @ts-ignore
    connections: [
      [
        Hyprland.active.workspace,
        (
          /** @type {{ children: import("./types/widgets/button").Button<import("./types/widgets/label").Label<unknown>, unknown>[]; }} */ self
        ) => {
          const Wicons = [
            "",
            " ",
            " ",
            "󰨞 ",
            " ",
            " ",
            " ",
            " ",
            " ",
            "󰊖 ",
            "",
          ];
          const arr = Array.from({ length: 10 }, (_, i) => i + 1);
          self.children = arr.map((i) => {
            let className = "bc"; // default value

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
        },
      ],
    ],
  });

const date = Variable("", {
  poll: [60000, 'date "+%H:%M %b %e"'],
});
const Clock = () =>
  Widget.Label({
    class_name: "clock",
    label: date.bind(),
  });

function Notification() {
  const popups = notifications.bind("popups");
  return Widget.Box({
    class_name: "notification",
    visible: popups.as((p) => p.length > 0),
    children: [
      Widget.Icon({
        icon: "preferences-system-notifications-symbolic",
      }),
      Widget.Label({
        label: popups.as((p) => p[0]?.summary || ""),
      }),
    ],
  });
}

const MusicPlayerDaemon = Widget.Button({
  className: "media",
  child: Widget.Label({
    // @ts-ignore
    connections: [
      [
        1000,
        (/** @type {{ label: string; }} */ self) =>
          execAsync([
            "/usr/bin/mpc",
            "--format",
            "[%artist% - %title%]",
            "current",
          ])
            .then((date) => (self.label = date))
            .catch(console.error),
      ],
    ],
  }),
  on_primary_click: () =>
    execAsync(
      `/usr/bin/alacritty --class floatcritty -e /usr/bin/ncmpcpp -c /home/archkye/.ncmpcpp/config`
    ),
});

const Rofi = Widget.Button({
  className: "bc",
  child: Widget.Label("⏻"),
  on_primary_click: () =>
    execAsync(`/home/archkye/.config/rofi/powermenu/type-4/powermenu.sh`),
});
const Power = Widget.Button({
  className: "bc",
  child: Widget.Label("󱓞"),
  on_primary_click: () =>
    execAsync(`/home/archkye/.config/rofi/launchers/type-3/launcher.sh`),
});

const Volume = () =>
  Widget.Button({
    className: "volume",
    onScrollUp: () =>
      execAsync(`/usr/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+`),
    onScrollDown: () =>
      execAsync(`/usr/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-`),
    child: Widget.Box({
      children: [
        Widget.Stack({
          items: [
            // tuples of [string, Widget]
            ["101", Widget.Icon("audio-volume-overamplified-symbolic")],
            ["67", Widget.Icon("audio-volume-high-symbolic")],
            ["34", Widget.Icon("audio-volume-medium-symbolic")],
            ["1", Widget.Icon("audio-volume-low-symbolic")],
            ["0", Widget.Icon("audio-volume-muted-symbolic")],
          ],
          // @ts-ignore
          connections: [
            [
              Audio,
              (/** @type {{ shown: string; }} */ self) => {
                if (!Audio.speaker) return;

                if (Audio.speaker.is_muted) {
                  self.shown = "0";
                  return;
                }

                const show = [101, 67, 34, 1, 0].find(
                  (threshold) => threshold <= Audio.speaker.volume * 100
                );

                self.shown = `${show}`;
              },
              "speaker-changed",
            ],
          ],
        }),
        Widget.Label({
          // @ts-ignore
          connections: [
            [
              Audio,
              (/** @type {{ label: string; }} */ self) => {
                self.label = `   ${Math.round(Audio.speaker.volume * 100)}`;
              },
              "speaker-changed",
            ],
          ],
        }),
      ],
    }),
  });

const SysTray = () =>
  Widget.Box({
    className: "systray",
    // @ts-ignore
    connections: [
      [
        SystemTray,
        (
          /** @type {{ children: import("./types/widgets/button").Button<import("./types/widgets/icon").Icon<unknown>, unknown>[]; }} */ self
        ) => {
          self.children = SystemTray.items.map((item) =>
            Widget.Button({
              // @ts-ignore
              child: Widget.Icon({ binds: [["icon", item, "icon"]] }),
              onPrimaryClick: (_, event) => item.activate(event),
              onSecondaryClick: (_, event) => item.openMenu(event),
              // @ts-ignore
              binds: [["tooltip-markup", item, "tooltip-markup"]],
            })
          );
        },
      ],
    ],
  });

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

// @ts-ignore
const Bar = ({ monitor } = {}) =>
  Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    className: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      startWidget: Left(),
      centerWidget: Center(),
      endWidget: Right(),
    }),
  });

// exporting the config so ags can manage the windows
export default {
  style: App.configDir + "/style.css",
  windows: [
    Bar(),

    // you can call it, for each monitor
    // Bar({ monitor: 0 }),
    // Bar({ monitor: 1 })
  ],
};
