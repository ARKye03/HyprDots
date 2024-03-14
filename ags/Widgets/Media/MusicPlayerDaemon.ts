import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

export const MusicPlayerDaemon = Widget.Button({
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
  on_primary_click: () => execAsync(`ags -t MediaWidget`),
  /*     execAsync(
      `/usr/bin/alacritty --class floatcritty -e /usr/bin/ncmpcpp -c /home/archkye/.ncmpcpp/config`
    ), */
});
