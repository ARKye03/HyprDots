// importing
import Hyprland from "resource:///com/github/Aylur/ags/service/hyprland.js";
import { notifications } from "resource:///com/github/Aylur/ags/service/notifications.js";
import Audio from "resource:///com/github/Aylur/ags/service/audio.js";
import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";
import App from "resource:///com/github/Aylur/ags/app.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

const Workspaces = () =>
  Widget.Box({
    className: "workspaces",
    setup: (self) => {
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
    setup: (self) => {
      const updateLabel = () => {
        execAsync([
          "/usr/bin/mpc",
          "--format",
          "[%title% - %artist%]",
          "current",
        ])
          .then((date) => {
            self.label = date;
            // Wait for player status change and then update the label again
            execAsync(["mpc", "idle", "player"]).then(updateLabel);
          })
          .catch(console.error);
      };
      updateLabel();
    },
  }),
  on_primary_click_release: () =>
    execAsync(
      `/usr/bin/alacritty --class floatcritty -e /usr/bin/ncmpcpp -c /home/archkye/.ncmpcpp/config`
    ),
});

const Rofi = Widget.Button({
  className: "bc",
  child: Widget.Label(" ⏻ "),
  on_primary_click_release: () =>
    execAsync(`/home/archkye/.config/rofi/powermenu/type-4/powermenu.sh`),
});
const Power = Widget.Button({
  className: "bc",
  child: Widget.Label(" 󱓞 "),
  on_primary_click_release: () =>
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
      setup: (self) => {
        const updateVolume = () => {
          const volumeIcon = Widget.Icon().hook(Audio.speaker, (self) => {
            const category = {
              101: "overamplified",
              67: "high",
              34: "medium",
              1: "low",
              0: "muted",
            };

            const icon = Audio.speaker.is_muted
              ? 0
              : [101, 67, 34, 1, 0].find(
                  (threshold) => threshold <= Audio.speaker.volume * 100
                );

            self.icon = `audio-volume-${category[icon]}-symbolic`;
          });

          const volumeLabel = Widget.Label({
            label: `   ${Math.round(Audio.speaker.volume * 100)}`,
          });

          self.children = [volumeIcon, volumeLabel];
        };

        self.hook(Audio, updateVolume, "speaker-changed");
        updateVolume();
      },
    }),
  });

const SysTray = () =>
  Widget.Box({
    className: "systray",
    children: SystemTray.bind("items").as((items) =>
      items.map((item) =>
        Widget.Button({
          child: Widget.Icon({ icon: item.bind("icon") }),
          on_primary_click: (_, event) => item.activate(event),
          on_secondary_click: (_, event) => item.openMenu(event),
          tooltip_markup: item.bind("tooltip_markup"),
        })
      )
    ),
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
