import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

export const MusicPlayerDaemon = Widget.Button({
  className: "media",
  can_focus: false,

  child: Widget.Label({
    setup: (self) => {
      const updateLabel = () => {
        execAsync(["/usr/bin/mpc", "--format", "%title%", "current"])
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
  on_clicked: () => App.ToggleWindow("MediaWidget"),
});
