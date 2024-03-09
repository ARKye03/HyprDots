import Widget from "resource:///com/github/Aylur/ags/widget.js";

export const BarMenu = () => {
  Widget.Window({
    name: "bar_menu",
    visible: false,
    anchor: ["top", "right"],
    child: Widget.Label("1"),
  });
};
