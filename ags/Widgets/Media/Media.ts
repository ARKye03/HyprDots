import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

const songTitle = "";
const artistName = "";
const albumName = "";

const songTitleLabel = Widget.Label({ label: songTitle });
const artistNameLabel = Widget.Label({ label: artistName });
const albumNameLabel = Widget.Label({ label: albumName });

const positionSlider = Widget.Slider({
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

const playButton = Widget.Button({
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
const nextButton = Widget.Button({
  on_primary_click_release: () => execAsync(["mpc", "next"]),
  child: Widget.Icon({
    icon: "/home/archkye/.config/ags/assets/MediaWidget/Next.svg",
  }),
});
const prevButton = Widget.Button({
  on_primary_click_release: () => execAsync(["mpc", "prev"]),
  child: Widget.Icon({
    icon: "/home/archkye/.config/ags/assets/MediaWidget/Prev.svg",
  }),
});
const singleMode = Widget.Button({
  on_primary_click_release: () => execAsync(["mpc", "single"]),
  child: Widget.Icon({
    icon: "/home/archkye/.config/ags/assets/MediaWidget/Single.svg",
  }),
});
const repeatMode = Widget.Button({
  on_primary_click_release: () => execAsync(["mpc", "repeat"]),
  child: Widget.Icon({
    icon: "/home/archkye/.config/ags/assets/MediaWidget/Repeat.svg",
  }),
});
const openPlayer = Widget.Button({
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

export const MediaWidget = () =>
  Widget.Window({
    name: "MediaWidget",
    class_name: "media-window",
    visible: false,
    anchor: ["top"],
    child: Widget.Box({
      children: [
        Widget.Box({
          vertical: true,
          children: [singleMode, repeatMode, openPlayer],
        }),
        Widget.Box({
          class_name: "media-info",
          vertical: true,
          children: [
            songTitleLabel,
            albumNameLabel,
            artistNameLabel,
            positionSlider,
          ],
        }),
        Widget.Box({
          vertical: true,
          children: [playButton, nextButton, prevButton],
        }),
      ],
      setup: (self) => {
        const updateWidget = () => {
          execAsync([
            "/usr/bin/mpc",
            "--format",
            "[%title% - %artist% - %album%]",
            "current",
          ])
            .then((data) => {
              const [title, artist, album] = data.split(" - ");
              if (title !== undefined) songTitleLabel.label = title;
              if (artist !== undefined) artistNameLabel.label = artist;
              if (album !== undefined) albumNameLabel.label = album;

              // Check if a song is currently playing
              execAsync(["mpc", "status"])
                .then((status) => {
                  if (status.includes("[playing]")) {
                    playButton.child.icon =
                      "/home/archkye/.config/ags/assets/MediaWidget/Stop.svg";
                  } else {
                    playButton.child.icon =
                      "/home/archkye/.config/ags/assets/MediaWidget/Play.svg";
                  }
                })
                .catch(console.error);

              execAsync(["mpc", "idle", "player"]).then(updateWidget);
            })
            .catch(console.error);
        };
        updateWidget();
      },
    }),
  });
