import Widget from "resource:///com/github/Aylur/ags/widget.js";

export const calendar = Widget.Window({
  name: "calendarium",
  anchor: ["top", "right"],
  visible: false,
  child: Widget.Calendar({
    class_name: "calendarium",
  }),
});

const date = Variable("", {
  poll: [60000, 'date "+%I:%M %p %b %e"'],
});
export const Clock = () =>
  Widget.Button({
    class_name: "clock",
    on_clicked: () => App.ToggleWindow("calendarium"),
    child: Widget.Label({
      label: date.bind(),
    }),
  });
