import Audio from "resource:///com/github/Aylur/ags/service/audio.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";
import { execAsync } from "resource:///com/github/Aylur/ags/utils.js";

export const Volume = () =>
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

            self.icon = `audio-volume-${
              category[icon as keyof typeof category]
            }-symbolic`;
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
