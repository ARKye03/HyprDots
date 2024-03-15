import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";
import {
  singleMode,
  repeatMode,
  openPlayer,
  songTitleLabel,
  albumNameLabel,
  artistNameLabel,
  positionSlider,
  playButton,
  nextButton,
  prevButton,
} from "./MediaComponents";

export const MediaWidget = () =>
  Widget.Window({
    name: "MediaWidget",
    exclusivity: "normal",
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
