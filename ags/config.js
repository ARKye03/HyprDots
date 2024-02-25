// importing 
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import Notifications from 'resource:///com/github/Aylur/ags/service/notifications.js';
import Audio from 'resource:///com/github/Aylur/ags/service/audio.js';
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import { exec, execAsync } from 'resource:///com/github/Aylur/ags/utils.js';
// widgets can be only assigned as a child in one container
// so to make a reuseable widget, just make it a function
// then you can use it by calling simply calling it

const Workspaces = () => Widget.Box({
    className: 'workspaces',
    connections: [[Hyprland.active.workspace, self => {
        const Wicons = ['', ' ', ' ', '󰨞 ', ' ', ' ', ' ', ' ', ' ', '󰊖 ', ' ']
        // generate an array [1..10] then make buttons from the index
        const arr = Array.from({ length: 10 }, (_, i) => i + 1);
        self.children = arr.map(i => {
            let className = 'bc'; // default value

            if (Hyprland.active.workspace.id === i) {
                className = 'focused';
            } else if (Hyprland.workspaces.some(ws => ws.id === i && ws.windows > 0)) {
                className = 'work';
            }

            return Widget.Button({
                onClicked: () => execAsync(`hyprctl dispatch workspace ${i}`),
                child: Widget.Label(`${Wicons[i]}`),
                className: className
            });
        });
    }]],
});

const Clock = () => Widget.Label({
    className: 'clock',
    connections: [
        // this is bad practice, since exec() will block the main event loop
        // in the case of a simple date its not really a problem
        [1000, self => self.label = exec('date "+%H:%M:%S %b %e."')],

        // this is what you should do
        [1000, self => execAsync(['date', '+%H:%M:%S %b %e.'])
            .then(date => self.label = date).catch(console.error)],
    ],
});
// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
const Notification = () => Widget.Box({
    className: 'notification',
    children: [
        Widget.Icon({
            icon: 'preferences-system-notifications-symbolic',
            connections: [
                [Notifications, self => self.visible = Notifications.popups.length > 0],
            ],
        }),
        Widget.Label({
            connections: [[Notifications, self => {
                self.label = Notifications.popups[0]?.summary || '';
            }]],
        }),
    ],
});

const Rofi = Widget.Button({
    className: 'bc',
    child: Widget.Label('⏻'),
    on_primary_click: () => execAsync(`home/archkye/.config/rofi/powermenu/type-4/powermenu.sh`),
});
const Power = Widget.Button({
    className: 'bc',
    child: Widget.Label('󱓞'),
    on_primary_click: () => execAsync(`/home/archkye/.config/rofi/launchers/type-3/launcher.sh`),
});

const Volume = () => Widget.Box({
    className: 'volume',
    css: 'min-width: 180px',
    children: [
        Widget.Stack({
            items: [
                // tuples of [string, Widget]
                ['101', Widget.Icon('audio-volume-overamplified-symbolic')],
                ['67', Widget.Icon('audio-volume-high-symbolic')],
                ['34', Widget.Icon('audio-volume-medium-symbolic')],
                ['1', Widget.Icon('audio-volume-low-symbolic')],
                ['0', Widget.Icon('audio-volume-muted-symbolic')],
            ],
            connections: [[Audio, self => {
                if (!Audio.speaker)
                    return;

                if (Audio.speaker.isMuted) {
                    self.shown = '0';
                    return;
                }

                const show = [101, 67, 34, 1, 0].find(
                    threshold => threshold <= Audio.speaker.volume * 100);

                self.shown = `${show}`;
            }, 'speaker-changed']],
        }),
        Widget.Slider({
            hexpand: true,
            drawValue: false,
            onChange: ({ value }) => Audio.speaker.volume = value,
            connections: [[Audio, self => {
                self.value = Audio.speaker?.volume || 0;
            }, 'speaker-changed']],
        }),
    ],
});

const SysTray = () => Widget.Box({
    className: 'systray',
    connections: [[SystemTray, self => {
        self.children = SystemTray.items.map(item => Widget.Button({
            child: Widget.Icon({ binds: [['icon', item, 'icon']] }),
            onPrimaryClick: (_, event) => item.activate(event),
            onSecondaryClick: (_, event) => item.openMenu(event),
            binds: [['tooltip-markup', item, 'tooltip-markup']],
        }));
    }]],
});

// layout of the bar
const Left = () => Widget.Box({
    children: [
        Workspaces(),
    ],
});

const Center = () => Widget.Box({
    children: [
        Rofi,
        Notification(),
        Clock(),
        Power
    ],
});

const Right = () => Widget.Box({
    hpack: 'end',
    children: [
        Volume(),
        SysTray(),
    ],
});

const Bar = ({ monitor } = {}) => Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    className: 'bar',
    monitor,
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
        startWidget: Left(),
        centerWidget: Center(),
        endWidget: Right(),
    }),
})


// exporting the config so ags can manage the windows
export default {
    style: App.configDir + '/style.css',
    windows: [
        Bar(),

        // you can call it, for each monitor
        // Bar({ monitor: 0 }),
        // Bar({ monitor: 1 })
    ],
};
