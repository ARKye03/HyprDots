export const Chat = () =>
  Widget.Window({
    name: "Chat",
    keymode: "on-demand",
    width_request: 400,
    visible: false,
    class_name: "chat",
    anchor: ["top", "right", "bottom"],
    child: Widget.CenterBox({
      vertical: true,
      startWidget: Widget.Box(
        Widget.Label({
          label: "Gemini here for you.",
          justification: "left",
        }),
        Widget.Icon({
          icon: "/home/archkye/.config/ags/Widgets/GeminiAI/pacman.svg",
          class_name: "pacman",
          size: 60,
        })
      ),
      centerWidget: Widget.Label({
        css: "background-color: #3B192F",
        label: "MOREEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEe",
        height_request: 900,
      }),
      endWidget: Widget.Box({
        height_request: 40,
        spacing: 8,
        homogeneous: false,
        vertical: false,
        children: [
          Widget.Entry({
            placeholder_text: "Ask Gemini...",
            visibility: true, // set to false for passwords
            onAccept: ({ text }) => print(text),
          }),
          Widget.Button(),
        ],
      }),
    }),
  });
