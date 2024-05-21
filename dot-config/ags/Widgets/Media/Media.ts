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
import { icons } from "assets/Assets";

export const MediaWidget = () =>
  Widget.Window({
    name: "MediaWidget",
    class_name: "media-window",
    visible: false,
    anchor: ["top"],
    child: Widget.Box({
      css: "padding: 1px;",
      child: Widget.Revealer({
        revealChild: false,
        transitionDuration: 150,
        transition: "slide_down",
        setup: (self) => {
          self.hook(
            App,
            (self, windowName, visible) => {
              if (windowName === "MediaWidget") {
                self.reveal_child = visible;
              }
            },
            "window-toggled"
          );
        },
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
          setup: () => {
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
                  else songTitleLabel.label = "~";
                  if (artist !== undefined) artistNameLabel.label = artist;
                  else artistNameLabel.label = "~";
                  if (album !== undefined) albumNameLabel.label = album;
                  else albumNameLabel.label = "~";

                  // Check if a song is currently playing
                  execAsync(["mpc", "status"])
                    .then((status) => {
                      if (status.includes("[playing]")) {
                        playButton.child.icon = icons.stopSvg;
                      } else {
                        playButton.child.icon = icons.playSvg;
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
      }),
    }),
  });
