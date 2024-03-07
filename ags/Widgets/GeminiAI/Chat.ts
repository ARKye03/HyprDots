export const Chat = () =>
  Widget.Window({
    name: "Chat",
    class_name: "chat",
    anchor: ["top", "right", "bottom"],
    child: Widget.Button({
      on_primary_click_release: () => console.log("Hello"),
      child: Widget.Label("HOLAAAAAAAAAAA"),
    }),
  });
