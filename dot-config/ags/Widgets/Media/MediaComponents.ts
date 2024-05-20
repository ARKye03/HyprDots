import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

const songTitle = "";
const artistName = "";
const albumName = "";
export const songTitleLabel = Widget.Label({ label: songTitle });
export const artistNameLabel = Widget.Label({ label: artistName });
export const albumNameLabel = Widget.Label({ label: albumName });
export const positionSlider = Widget.Slider({
  width_request: 200,
  class_name: "position",
  draw_value: false,
  on_change: ({ value }) => {
    execAsync(["mpc", "seek", `${value * 100}%`]);
  },
  setup: (self) => {
    const update = () => {
      Promise.all([
        execAsync(["mpc", "status", "%currenttime%"]),
        execAsync(["mpc", "status", "%totaltime%"]),
      ])
        .then(([currentTime, totalTime]) => {
          const current =
            parseInt(currentTime.split(":")[0]) * 60 +
            parseInt(currentTime.split(":")[1]);
          const total =
            parseInt(totalTime.split(":")[0]) * 60 +
            parseInt(totalTime.split(":")[1]);
          self.visible = total > 0;
          self.value = current / total;
        })
        .catch((error) => {
          console.error("Error caught: ", error);
        });
    };
    self.poll(1000, update);
  },
});
export const playButton = Widget.Button({
  on_primary_click_release: () => {
    execAsync(["mpc", "toggle"]).then(() => {
      // Toggle the label and icon between "Play" and "Stop"
      if (
        playButton.child.icon ===
        "/home/archkye/.config/ags/assets/MediaWidget/Play.svg"
      ) {
        playButton.child.icon =
          "/home/archkye/.config/ags/assets/MediaWidget/Stop.svg";
      } else {
        playButton.child.icon =
          "/home/archkye/.config/ags/assets/MediaWidget/Play.svg";
      }
    });
  },
  child: Widget.Icon({
    icon: "/home/archkye/.config/ags/assets/MediaWidget/Play.svg",
  }),
});
export const nextButton = Widget.Button({
  on_primary_click_release: () => execAsync(["mpc", "next"]),
  child: Widget.Icon({
    icon: "/home/archkye/.config/ags/assets/MediaWidget/Next.svg",
  }),
});
export const prevButton = Widget.Button({
  on_primary_click_release: () => execAsync(["mpc", "prev"]),
  child: Widget.Icon({
    icon: "/home/archkye/.config/ags/assets/MediaWidget/Prev.svg",
  }),
});
export const singleMode = Widget.Button({
  on_primary_click_release: () => execAsync(["mpc", "single"]),
  child: Widget.Icon({
    icon: "/home/archkye/.config/ags/assets/MediaWidget/Single.svg",
  }),
});
export const repeatMode = Widget.Button({
  on_primary_click_release: () => execAsync(["mpc", "repeat"]),
  child: Widget.Icon({
    icon: "/home/archkye/.config/ags/assets/MediaWidget/Repeat.svg",
  }),
});
export const openPlayer = Widget.Button({
  on_primary_click_release: () => {
    execAsync(
      `/usr/bin/alacritty --class floatcritty
        -e /usr/bin/ncmpcpp -c /home/archkye/.ncmpcpp/config`
    );
    execAsync(["ags", "-t", "MediaWidget"]);
  },
  child: Widget.Icon({
    icon: "/home/archkye/.config/ags/assets/MediaWidget/OpenPlayer.svg",
  }),
});
