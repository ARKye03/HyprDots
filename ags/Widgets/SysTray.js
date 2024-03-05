import SystemTray from "resource:///com/github/Aylur/ags/service/systemtray.js";
import Widget from "resource:///com/github/Aylur/ags/widget.js";

export const SysTray = () =>
  Widget.Box({
    className: "systray",
    children: SystemTray.bind("items").as((items) =>
      items.map((item) =>
        Widget.Button({
          child: Widget.Icon({ icon: item.bind("icon") }),
          on_primary_click: (_, event) => item.activate(event),
          on_secondary_click: (_, event) => item.openMenu(event),
          tooltip_markup: item.bind("tooltip_markup"),
        })
      )
    ),
  });
