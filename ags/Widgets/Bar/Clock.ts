import Widget from "resource:///com/github/Aylur/ags/widget.js";

const date = Variable("", {
  poll: [60000, 'date "+%I:%M %p %b %e"'],
});
export const Clock = () =>
  Widget.Label({
    class_name: "clock",
    label: date.bind(),
  });
